from typing import List

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from config import get_db
from models.timekeeping import Timekeeping
from models.user import User
from repositories.jwt_repository import JWTBearer
from repositories.timekeeping_repository import TimekeepingRepository
from repositories.user_repository import UserRepository
from schemas.schema import ResponseSchema
from schemas.timekeeping_schema import TimekeepingSchema
from ultis.permission import check_permission_role_admin
from ultis.security import get_current_user

timekeeping_route = APIRouter(prefix="/timekeeping", tags=["Timekeeping"])


@timekeeping_route.get("/", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[List[TimekeepingSchema]])
def get_all_timekeeping(id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    timekeepings = TimekeepingRepository.find_all(db, Timekeeping)
    return ResponseSchema.from_api_route(status_code=200, data=timekeepings).dict(exclude_none=True)


@timekeeping_route.get("/{timekeeping_id}", dependencies=[Depends(JWTBearer())],
                       response_model=ResponseSchema[TimekeepingSchema])
def get_timekeeping_by_id(timekeeping_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    timekeeping = TimekeepingRepository.find_by_id(db, Timekeeping, timekeeping_id)
    if not timekeeping:
        return ResponseSchema.from_api_route(status_code=404, data="Timekeeping not found").dict(exclude_none=True)
    return ResponseSchema.from_api_route(status_code=200, data=timekeeping).dict(exclude_none=True)


@timekeeping_route.get("/user/{user_id}", dependencies=[Depends(JWTBearer())],
                       response_model=ResponseSchema[List[TimekeepingSchema]])
def get_timekeeping_by_user_id(user_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    timekeeping = TimekeepingRepository.find_by_user_id(db, user_id)
    if not timekeeping:
        return ResponseSchema.from_api_route(status_code=404, data="Timekeeping not found").dict(exclude_none=True)
    return ResponseSchema.from_api_route(status_code=200, data=timekeeping).dict(exclude_none=True)


@timekeeping_route.get("/user/{user_id}/{month}", dependencies=[Depends(JWTBearer())],
                       response_model=ResponseSchema[List[TimekeepingSchema]])
def get_timekeeping_by_user_id_and_month(user_id: int, month: int, id: int = Depends(get_current_user),
                                         db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    timekeeping = TimekeepingRepository.find_by_user_id_and_month(db, user_id, month)
    if not timekeeping:
        return ResponseSchema.from_api_route(status_code=404, data="Timekeeping not found").dict(exclude_none=True)
    return ResponseSchema.from_api_route(status_code=200, data=timekeeping).dict(exclude_none=True)


@timekeeping_route.get("/user/{user_id}/{month}/{year}", dependencies=[Depends(JWTBearer())],
                       response_model=ResponseSchema[TimekeepingSchema])
def get_timekeeping_by_user_id_and_month_and_year(user_id: int, month: int, year: int,
                                                  id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    timekeeping = TimekeepingRepository.find_by_user_id_and_month_and_year(db, user_id, month, year)
    if not timekeeping:
        return ResponseSchema.from_api_route(status_code=404, data="Timekeeping not found").dict(exclude_none=True)
    return ResponseSchema.from_api_route(status_code=200, data=timekeeping).dict(exclude_none=True)


@timekeeping_route.post("/", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[TimekeepingSchema])
def create_timekeeping(timekeeping: TimekeepingSchema, id: int = Depends(get_current_user),
                       db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    user = UserRepository.find_by_id(db, User, timekeeping.user_id)
    if not user:
        return ResponseSchema.from_api_route(status_code=404, data="User not found").dict(exclude_none=True)
    timekeeping = TimekeepingRepository.insert(db, Timekeeping(**timekeeping.dict()))
    return ResponseSchema.from_api_route(status_code=201, data=timekeeping).dict(exclude_none=True)


@timekeeping_route.put("/{timekeeping_id}", dependencies=[Depends(JWTBearer())],
                       response_model=ResponseSchema[TimekeepingSchema])
def update_timekeeping(timekeeping_id: int, timekeeping: TimekeepingSchema, id: int = Depends(get_current_user),
                       db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    user = UserRepository.find_by_id(db, User, timekeeping.user_id)
    if not user:
        return ResponseSchema.from_api_route(status_code=404, data="User not found").dict(exclude_none=True)
    timekeeping_ed = TimekeepingRepository.find_by_id(db, Timekeeping, timekeeping_id)
    if not timekeeping_ed:
        return ResponseSchema.from_api_route(status_code=404, data="Timekeeping not found").dict(exclude_none=True)
    timekeeping_ed.month = timekeeping.month
    timekeeping_ed.year = timekeeping.year
    timekeeping_ed.user_id = timekeeping.user_id
    TimekeepingRepository.update(db, timekeeping_ed)
    return ResponseSchema.from_api_route(status_code=200, data=timekeeping_ed).dict(exclude_none=True)


@timekeeping_route.delete("/{timekeeping_id}", dependencies=[Depends(JWTBearer())],
                          response_model=ResponseSchema[TimekeepingSchema])
def delete_timekeeping(timekeeping_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    timekeeping = TimekeepingRepository.find_by_id(db, Timekeeping, timekeeping_id)
    if not timekeeping:
        return ResponseSchema.from_api_route(status_code=404, data="Timekeeping not found").dict(exclude_none=True)
    TimekeepingRepository.delete(db, timekeeping)
    return ResponseSchema.from_api_route(status_code=200, data=timekeeping).dict(exclude_none=True)


