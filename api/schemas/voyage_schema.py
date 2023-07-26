from pydantic import BaseModel


class VoyageSchemaBase(BaseModel):
    pick_up_staff_id: int
    delivery_staff_id: int
    delivery_status: str


class VoyageSchema(VoyageSchemaBase):
    id: int
    invoice_id: int
    headquarter_id: int
    port_id: int

    class Config:
        orm_mode = True
