from contextlib import asynccontextmanager

from fastapi import Depends, FastAPI, HTTPException, Query, status
from sqlalchemy import text
from sqlalchemy.orm import Session

from .database import Base, engine, get_db
from .models import Mission
from .repository import create_mission, get_mission, list_missions, nearby_missions
from .schemas import MissionCreate, MissionOut


@asynccontextmanager
async def lifespan(app: FastAPI):
    # La migración/seed real se ejecuta con scripts; esto solo garantiza las tablas.
    Base.metadata.create_all(bind=engine)
    yield


app = FastAPI(
    title="SideQuest API",
    version="0.1.0",
    description="API geoespacial para misiones de exploración urbana.",
    lifespan=lifespan,
)


@app.get("/health")
def health(db: Session = Depends(get_db)):
    db.execute(text("SELECT 1"))
    return {"status": "ok", "service": "sidequest-api"}


@app.get("/api/v1/missions", response_model=list[MissionOut])
def missions(
    category: str | None = None,
    difficulty: str | None = None,
    db: Session = Depends(get_db),
):
    return list_missions(db, category=category, difficulty=difficulty)


@app.get("/api/v1/missions/nearby")
def missions_nearby(
    latitude: float = Query(ge=-90, le=90),
    longitude: float = Query(ge=-180, le=180),
    radius_km: float = Query(default=10, gt=0, le=100),
    db: Session = Depends(get_db),
):
    return nearby_missions(db, latitude, longitude, radius_km)


@app.get("/api/v1/missions/{mission_id}", response_model=MissionOut)
def mission(mission_id: str, db: Session = Depends(get_db)):
    result = get_mission(db, mission_id)
    if result is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Misión no encontrada")
    return result


@app.post("/api/v1/missions", response_model=MissionOut, status_code=status.HTTP_201_CREATED)
def mission_create(payload: MissionCreate, db: Session = Depends(get_db)):
    if get_mission(db, payload.id):
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail="Ya existe una misión con ese id")
    return create_mission(db, payload)
