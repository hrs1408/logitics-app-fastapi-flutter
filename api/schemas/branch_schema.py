from typing import List, Optional

from pydantic import BaseModel


class PortBase(BaseModel):
    port_name: str
    port_type: str


class PortSchema(PortBase):
    id: int
    warehouse_id: int

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


class WarehouseSchema(WarehouseBase):
    id: int
    branch_id: int
    ports: Optional[List[PortSchema]]

    class Config:
        orm_mode = True


class BranchSchemaBase(BaseModel):
    branch_name: str
    province: str


class BranchSchema(BranchSchemaBase):
    id: int
    headquarters: Optional[List['HeadquarterSchema']]

    class Config:
        orm_mode = True
