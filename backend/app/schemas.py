from pydantic import BaseModel, ConfigDict, Field


class MissionOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: str
    title: str
    description: str
    category: str
    difficulty: str
    xp: int
    location_name: str
    latitude: float
    longitude: float
    radius_meters: int


class MissionCreate(BaseModel):
    id: str = Field(min_length=2, max_length=80)
    title: str = Field(min_length=2, max_length=160)
    description: str = Field(min_length=2)
    category: str = Field(min_length=2, max_length=80)
    difficulty: str = Field(min_length=2, max_length=40)
    xp: int = Field(ge=1, le=10000)
    location_name: str = Field(min_length=2, max_length=180)
    latitude: float = Field(ge=-90, le=90)
    longitude: float = Field(ge=-180, le=180)
    radius_meters: int = Field(default=180, ge=25, le=5000)
