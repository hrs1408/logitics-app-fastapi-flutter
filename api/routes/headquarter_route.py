from typing import List

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from config import get_db
from models.branch import Branch, Headquarter
from repositories.branch_repository import HeadquarterRepository, BranchRepository
from repositories.jwt_repository import JWTBearer
from schemas.branch_schema import HeadquarterSchema, HeadquarterBase
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
    headquarters = HeadquarterRepository.find_all(db, Headquarter)
    return ResponseSchema.from_api_route(status_code=200, data=headquarters).dict(exclude_none=True)


@headquarter_route.get("/{headquarter_id}", dependencies=[Depends(JWTBearer())],
                       response_model=ResponseSchema[str])
def get_headquarter_by_id(headquarter_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    headquarter = HeadquarterRepository.find_by_id(db, Headquarter, headquarter_id)
    if not headquarter:
        raise HTTPException(status_code=404, detail="Headquarter not found")
    return ResponseSchema.from_api_route(status_code=200, data=headquarter).dict(exclude_none=True)


@headquarter_route.post("/{branch_id}", dependencies=[Depends(JWTBearer())],
                        response_model=ResponseSchema[HeadquarterSchema])
def create_headquarter(headquarter: HeadquarterBase, branch_id: int, id: int = Depends(get_current_user),
                       db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    branch = BranchRepository.find_by_id(db, Branch, branch_id)
    if not branch:
        raise HTTPException(status_code=404, detail="Branch not found")
    headquarter_ext = HeadquarterRepository.find_by_name(db, headquarter.headquarter_name)
    if headquarter_ext:
        raise HTTPException(status_code=404, detail="Headquarter already exist")
    headquarter_ct = Headquarter(
        headquarter_name=headquarter.headquarter_name,
        address=headquarter.address,
        branch_id=branch_id
    )
    HeadquarterRepository.insert(db, headquarter_ct)
    return ResponseSchema.from_api_route(status_code=201, data=headquarter_ct).dict(exclude_none=True)


@headquarter_route.put("/{branch_id}/{headquarter_id}", dependencies=[Depends(JWTBearer())],
                       response_model=ResponseSchema[HeadquarterSchema])
def update_headquarter(branch_id: int, headquarter_id: int, headquarter: HeadquarterBase,
                       id: int = Depends(get_current_user),
                       db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    branch = BranchRepository.find_by_id(db, Branch, branch_id)
    if not branch:
        raise HTTPException(status_code=404, detail="Branch not found")
    headquarter_ed = HeadquarterRepository.find_by_id(db, Headquarter, headquarter_id)
    if not headquarter_ed:
        raise HTTPException(status_code=404, detail="Headquarter not found")
    headquarter_ed.headquarter_name = headquarter.headquarter_name
    headquarter_ed.address = headquarter.address
    HeadquarterRepository.update(db, headquarter_ed)
    return ResponseSchema.from_api_route(status_code=200, data=headquarter_ed).dict(exclude_none=True)


@headquarter_route.delete("/{headquarter_id}", dependencies=[Depends(JWTBearer())],
                          response_model=ResponseSchema[HeadquarterSchema])
def delete_headquarter(headquarter_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    headquarter = HeadquarterRepository.find_by_id(db, Headquarter, headquarter_id)
    if not headquarter:
        raise HTTPException(status_code=404, detail="Headquarter not found")
    HeadquarterRepository.delete(db, headquarter)
    return ResponseSchema.from_api_route(status_code=200, data=headquarter).dict(exclude_none=True)

@headquarter_route.get("/by-branch/{branch_id}", dependencies=[Depends(JWTBearer())],
                          response_model=ResponseSchema[List[HeadquarterSchema]])
def get_headquarter_by_branch_id(branch_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    headquarter = HeadquarterRepository.find_by_branch_id(db, branch_id)
    if not headquarter:
        raise HTTPException(status_code=404, detail="Headquarter not found")
    return ResponseSchema.from_api_route(status_code=200, data=headquarter).dict(exclude_none=True)