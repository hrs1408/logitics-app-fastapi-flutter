from typing import List

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from config import get_db
from models.branch import Branch
from repositories.branch_repository import HeadquarterRepository, BranchRepository
from repositories.jwt_repository import JWTBearer
from schemas.branch_schema import HeadquarterSchema
from schemas.schema import ResponseSchema
from ultis.permission import check_permission_role_admin
from ultis.security import get_current_user

headquarter_route = APIRouter(
    prefix="/headquarter",
    tags=["Headquarter"],
)


@headquarter_route.get("/", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[List[HeadquarterSchema]])
def get_all_headquarter(id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    headquarters = HeadquarterRepository.find_all(db)
    return ResponseSchema.from_api_route(status_code=200, data=headquarters).dict(exclude_none=True)


@headquarter_route.get("/{headquarter_id}", dependencies=[Depends(JWTBearer())],
                       response_model=ResponseSchema[HeadquarterSchema])
def get_headquarter_by_id(headquarter_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    headquarter = HeadquarterRepository.find_by_id(db, headquarter_id)
    if not headquarter:
        return ResponseSchema.from_api_route(status_code=404, data="Headquarter not found").dict(exclude_none=True)
    return ResponseSchema.from_api_route(status_code=200, data=headquarter).dict(exclude_none=True)


@headquarter_route.post("/", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[HeadquarterSchema])
def create_headquarter(headquarter: HeadquarterSchema, id: int = Depends(get_current_user),
                       db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    branch = BranchRepository.find_by_id(db, Branch, headquarter.branch_id)
    if not branch:
        return ResponseSchema.from_api_route(status_code=404, data="Branch not found").dict(exclude_none=True)
    headquarter = HeadquarterRepository.find_by_name(db, headquarter.headquarter_name)
    if headquarter:
        return ResponseSchema.from_api_route(status_code=400, data="Headquarter already exist").dict(exclude_none=True)
    headquarter = HeadquarterRepository.insert(db, headquarter)
    return ResponseSchema.from_api_route(status_code=201, data=headquarter).dict(exclude_none=True)


@headquarter_route.put("/{headquarter_id}", dependencies=[Depends(JWTBearer())],
                       response_model=ResponseSchema[HeadquarterSchema])
def update_headquarter(headquarter_id: int, headquarter: HeadquarterSchema, id: int = Depends(get_current_user),
                       db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    branch = BranchRepository.find_by_id(db, Branch, headquarter.branch_id)
    if not branch:
        return ResponseSchema.from_api_route(status_code=404, data="Branch not found").dict(exclude_none=True)
    headquarter_ed = HeadquarterRepository.find_by_id(db, headquarter_id)
    if not headquarter:
        return ResponseSchema.from_api_route(status_code=404, data="Headquarter not found").dict(exclude_none=True)
    headquarter_ed.headquarter_name = headquarter.headquarter_name
    headquarter_ed.address = headquarter.address
    HeadquarterRepository.update(db, headquarter_ed)
    return ResponseSchema.from_api_route(status_code=200, data=headquarter_ed).dict(exclude_none=True)


@headquarter_route.delete("/{headquarter_id}", dependencies=[Depends(JWTBearer())],
                          response_model=ResponseSchema[HeadquarterSchema])
def delete_headquarter(headquarter_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    headquarter = HeadquarterRepository.find_by_id(db, headquarter_id)
    if not headquarter:
        return ResponseSchema.from_api_route(status_code=404, data="Headquarter not found").dict(exclude_none=True)
    HeadquarterRepository.delete(db, headquarter)
    return ResponseSchema.from_api_route(status_code=200, data=headquarter).dict(exclude_none=True)
