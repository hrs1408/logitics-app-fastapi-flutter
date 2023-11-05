from typing import Optional, List

from pydantic import BaseModel

from schemas.branch_schema import PortSchema, HeadquarterSchema
from schemas.invoice_schema import InvoiceSchema
from schemas.user_schema import UserSchema
from schemas.vehicle_schema import VehicleSchema


class HistorySchemaBase(BaseModel):
    id: int
    voyage_id: int
    headquarter_id: int
    port_id: int
    delivery_status: str
    pickup_staff_id: int
    delivery_staff_id: int
    vehicle_id: int
    created_at: str


class VoyageSchemaBase(BaseModel):
    pickup_staff_id: int
    delivery_staff_id: int
    delivery_status: str
    headquarter_id: int
    vehicle_id: int
    port_id: int
    created_at: str


class VoyageSchema(VoyageSchemaBase):
    id: int
    invoice_id: int
    history: Optional[List['HistorySchemaBase']]

    class Config:
        orm_mode = True
