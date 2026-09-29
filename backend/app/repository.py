from geoalchemy2 import WKTElement
from sqlalchemy import text
from sqlalchemy.orm import Session

from .models import Mission
from .schemas import MissionCreate, MissionOut


def _row_to_mission(row) -> MissionOut:
    return MissionOut(
        id=row.id,
        title=row.title,
        description=row.description,
        category=row.category,
        difficulty=row.difficulty,
        xp=row.xp,
        location_name=row.location_name,
        latitude=float(row.latitude),
        longitude=float(row.longitude),
        radius_meters=row.radius_meters,
    )


def list_missions(db: Session, category: str | None = None, difficulty: str | None = None):
    query = db.query(Mission).filter(Mission.is_active.is_(True))
    if category:
        query = query.filter(Mission.category == category)
    if difficulty:
        query = query.filter(Mission.difficulty == difficulty)
    missions = query.order_by(Mission.title).all()
    if not missions:
        return []
    ids = [m.id for m in missions]
    rows = db.execute(
        text("""
            SELECT id, title, description, category, difficulty, xp,
                   location_name, ST_Y(location) AS latitude,
                   ST_X(location) AS longitude, radius_meters
            FROM missions
            WHERE id = ANY(:ids)
        """), {"ids": ids}
    ).mappings().all()
    by_id = {row["id"]: row for row in rows}
    return [_row_to_mission(by_id[m.id]) for m in missions if m.id in by_id]


def get_mission(db: Session, mission_id: str):
    row = db.execute(
        text("""
            SELECT id, title, description, category, difficulty, xp,
                   location_name, ST_Y(location) AS latitude,
                   ST_X(location) AS longitude, radius_meters
            FROM missions
            WHERE id = :mission_id AND is_active = TRUE
        """), {"mission_id": mission_id}
    ).mappings().first()
    return _row_to_mission(row) if row else None


def nearby_missions(db: Session, latitude: float, longitude: float, radius_km: float):
    rows = db.execute(
        text("""
            SELECT id, title, description, category, difficulty, xp,
                   location_name, ST_Y(location) AS latitude,
                   ST_X(location) AS longitude, radius_meters,
                   ST_Distance(
                       location::geography,
                       ST_SetSRID(ST_MakePoint(:longitude, :latitude), 4326)::geography
                   ) AS distance_meters
            FROM missions
            WHERE is_active = TRUE
              AND ST_DWithin(
                  location::geography,
                  ST_SetSRID(ST_MakePoint(:longitude, :latitude), 4326)::geography,
                  :radius_meters
              )
            ORDER BY distance_meters ASC
        """),
        {"latitude": latitude, "longitude": longitude, "radius_meters": radius_km * 1000},
    ).mappings().all()
    return [
        {**_row_to_mission(row).model_dump(), "distance_meters": round(float(row["distance_meters"]), 1)}
        for row in rows
    ]


def create_mission(db: Session, payload: MissionCreate):
    mission = Mission(
        id=payload.id,
        title=payload.title,
        description=payload.description,
        category=payload.category,
        difficulty=payload.difficulty,
        xp=payload.xp,
        location_name=payload.location_name,
        location=WKTElement(
            f"POINT({payload.longitude} {payload.latitude})",
            srid=4326,
        ),
        radius_meters=payload.radius_meters,
    )
    db.add(mission)
    db.commit()
    return get_mission(db, payload.id)
