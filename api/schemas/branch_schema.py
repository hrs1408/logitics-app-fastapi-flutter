from typing import List, Optional

from pydantic import BaseModel


class BranchSchema(BaseModel):
    id: int
    branch_name: str
    province: str
    headquarters: Optional[List['HeadquarterSchema']]

    class Config:
        orm_mode = True


class HeadquarterBase(BaseModel):
    headquarter_name: str
    address: str


class HeadquarterSchema(HeadquarterBase):
    id: int
    branch_id: int

    class Config:
        orm_mode = True


class WarehouseBase(BaseModel):
    warehouse_name: str
    address: str


class WarehouseCreateSchema(WarehouseBase):
    id: int
    branch_id: int

    class Config:
        orm_mode = True


class PortBase(BaseModel):
    port_name: str
    type_port: str


class PortSchema(PortBase):
    id: int
    warehouse_id: int

    class Config:
        orm_mode = True
