from pydantic import BaseModel


class VehicleBase(BaseModel):
    tonnage: int
    vehicle_type: str


class VehicleSchema(VehicleBase):
    id: int
    branch_id: int

    class Config:
        orm_mode = True
