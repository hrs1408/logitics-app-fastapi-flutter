from pydantic import BaseModel


class VoyageSchemaBase(BaseModel):
    pick_up_staff_id: int
    delivery_staff_id: int
    delivery_status: str
    headquarter_id: int
    vehicle_id: int
    port_id: int


class VoyageSchema(VoyageSchemaBase):
    id: int
    invoice_id: int

    class Config:
        orm_mode = True
