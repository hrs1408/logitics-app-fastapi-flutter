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
