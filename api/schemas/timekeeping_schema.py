from typing import List, Optional

from pydantic import BaseModel


class TimekeepingSchema(BaseModel):
    id: int
    month: int
    year: int
    user_id: int
    timekeeping_detail: Optional[List['TimekeepingDetailSchema']]

    class Config:
        orm_mode = True


class TimekeepingDetailBase(BaseModel):
    day: int
    time_in: str
    time_out: str


class TimekeepingDetailSchema(TimekeepingDetailBase):
    id: int
    timekeeping_id: int

    class Config:
        orm_mode = True
