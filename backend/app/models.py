from datetime import datetime

from geoalchemy2 import Geometry
from sqlalchemy import Boolean, DateTime, Integer, String, Text, func
from sqlalchemy.orm import Mapped, mapped_column

from .database import Base


class Mission(Base):
    __tablename__ = "missions"

    id: Mapped[str] = mapped_column(String(80), primary_key=True)
    title: Mapped[str] = mapped_column(String(160), nullable=False)
    description: Mapped[str] = mapped_column(Text, nullable=False)
    category: Mapped[str] = mapped_column(String(80), nullable=False, index=True)
    difficulty: Mapped[str] = mapped_column(String(40), nullable=False, index=True)
    xp: Mapped[int] = mapped_column(Integer, nullable=False)
    location_name: Mapped[str] = mapped_column(String(180), nullable=False)
    location: Mapped[object] = mapped_column(
        Geometry("POINT", srid=4326, spatial_index=True), nullable=False
    )
    radius_meters: Mapped[int] = mapped_column(Integer, nullable=False, default=180)
    is_active: Mapped[bool] = mapped_column(Boolean, nullable=False, default=True, index=True)
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=func.now(), nullable=False
    )
