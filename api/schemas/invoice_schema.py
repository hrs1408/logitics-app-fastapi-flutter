from pydantic import BaseModel


class InvoiceSchemaBase(BaseModel):
    rcv_full_name: str
    rcv_phone: str
    rcv_address: str
    rcv_ward: str
    rcv_province: str
    shipping_type: str
    weight: int
    quantity: int
    length: int
    commodity_value: int
    length: int
    width: int
    height: int
    cod_money: int
    kind_of_goods: str
    payment: str
    show_goods: str
    requirement_other: str
    paided: bool
    user_address_id: int


class InvoiceSchema(InvoiceSchemaBase):
    id: int
    user_id: int

    class Config:
        orm_mode = True


class InvoiceCreateSchema(InvoiceSchemaBase):
    user_id: int
    port_id: int
    delivery_status: str
    pick_up_staff_id: int
    delivery_staff_id: int
    vehicle_id: int
    headquarter_id: int
    fee: int



