from typing import List

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from config import get_db
from models.timekeeping import TimekeepingDetail
from repositories.jwt_repository import JWTBearer
from repositories.timekeeping_repository import TimekeepingDetailRepository
from schemas.schema import ResponseSchema
from schemas.timekeeping_schema import TimekeepingDetailSchema
from ultis.permission import check_permission_role_admin
from ultis.security import get_current_user

timekeeping_detail_route = APIRouter(
    prefix="/timekeeping_detail",
    tags=["Timekeeping Detail"],
)


@timekeeping_detail_route.get("/", dependencies=[Depends(JWTBearer())],
                              response_model=ResponseSchema[List[TimekeepingDetailSchema]])
def get_all_timekeeping_detail(id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    timekeeping_details = TimekeepingDetailRepository.find_all(db, TimekeepingDetail)
    return ResponseSchema.from_api_route(status_code=200, data=timekeeping_details).dict(exclude_none=True)


@timekeeping_detail_route.get("/{timekeeping_detail_id}", dependencies=[Depends(JWTBearer())],
                              response_model=ResponseSchema[TimekeepingDetailSchema])
def get_timekeeping_detail_by_id(timekeeping_detail_id: int, id: int = Depends(get_current_user),
                                 db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    timekeeping_detail = TimekeepingDetailRepository.find_by_id(db, TimekeepingDetail, timekeeping_detail_id)
    if not timekeeping_detail:
        return ResponseSchema.from_api_route(status_code=404, data="Timekeeping Detail not found").dict(
            exclude_none=True)
    return ResponseSchema.from_api_route(status_code=200, data=timekeeping_detail).dict(exclude_none=True)


@timekeeping_detail_route.get("/timekeeping/{timekeeping_id}", dependencies=[Depends(JWTBearer())],
                              response_model=ResponseSchema[List[TimekeepingDetailSchema]])
def get_timekeeping_detail_by_timekeeping_id(timekeeping_id: int, id: int = Depends(get_current_user),
                                             db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    timekeeping_detail = TimekeepingDetailRepository.find_by_timekeeping_id(db, timekeeping_id)
    if not timekeeping_detail:
        return ResponseSchema.from_api_route(status_code=404, data="Timekeeping Detail not found").dict(
            exclude_none=True)
    return ResponseSchema.from_api_route(status_code=200, data=timekeeping_detail).dict(exclude_none=True)


@timekeeping_detail_route.get("/user/{user_id}", dependencies=[Depends(JWTBearer())],
                              response_model=ResponseSchema[List[TimekeepingDetailSchema]])
def get_timekeeping_detail_by_user_id(user_id: int, id: int = Depends(get_current_user),
                                      db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    timekeeping_detail = TimekeepingDetailRepository.find_by_user_id(db, user_id)
    if not timekeeping_detail:
        return ResponseSchema.from_api_route(status_code=404, data="Timekeeping Detail not found").dict(
            exclude_none=True)
    return ResponseSchema.from_api_route(status_code=200, data=timekeeping_detail).dict(exclude_none=True)


@timekeeping_detail_route.post("/", dependencies=[Depends(JWTBearer())],
                               response_model=ResponseSchema[TimekeepingDetailSchema])
def create_timekeeping_detail(timekeeping_detail: TimekeepingDetailSchema, id: int = Depends(get_current_user),
                              db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    timekeeping_detail = TimekeepingDetailRepository.insert(db, TimekeepingDetail(**timekeeping_detail.dict()))
    return ResponseSchema.from_api_route(status_code=201, data=timekeeping_detail).dict(exclude_none=True)


@timekeeping_detail_route.put("/{timekeeping_detail_id}", dependencies=[Depends(JWTBearer())],
                              response_model=ResponseSchema[TimekeepingDetailSchema])
def update_timekeeping_detail(timekeeping_detail_id: int, timekeeping_detail: TimekeepingDetailSchema,
                              id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    timekeeping_detail_ed = TimekeepingDetailRepository.find_by_id(db, TimekeepingDetail, timekeeping_detail_id)
    if not timekeeping_detail_ed:
        return ResponseSchema.from_api_route(status_code=404, data="Timekeeping Detail not found").dict(
            exclude_none=True)
    timekeeping_detail_ed.timekeeping_id = timekeeping_detail.timekeeping_id
    timekeeping_detail_ed.day = timekeeping_detail.day
    timekeeping_detail_ed.time_in = timekeeping_detail.time_in
    timekeeping_detail_ed.time_out = timekeeping_detail.time_out
    TimekeepingDetailRepository.update(db, timekeeping_detail_ed)
    return ResponseSchema.from_api_route(status_code=200, data=timekeeping_detail_ed).dict(exclude_none=True)


@timekeeping_detail_route.delete("/{timekeeping_detail_id}", dependencies=[Depends(JWTBearer())],
                                 response_model=ResponseSchema[TimekeepingDetailSchema])
def delete_timekeeping_detail(timekeeping_detail_id: int, id: int = Depends(get_current_user),
                              db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    timekeeping_detail = TimekeepingDetailRepository.find_by_id(db, TimekeepingDetail, timekeeping_detail_id)
    if not timekeeping_detail:
        return ResponseSchema.from_api_route(status_code=404, data="Timekeeping Detail not found").dict(
            exclude_none=True)
    TimekeepingDetailRepository.delete(db, timekeeping_detail)
    return ResponseSchema.from_api_route(status_code=200, data=timekeeping_detail).dict(exclude_none=True)
