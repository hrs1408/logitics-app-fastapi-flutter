from typing import List

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from config import get_db
from models.branch import Branch
from repositories.branch_repository import BranchRepository
from repositories.jwt_repository import JWTBearer
from schemas.branch_schema import BranchSchema, BranchSchemaBase
from schemas.schema import ResponseSchema
from ultis.permission import check_permission_role_supper_admin
from ultis.security import get_current_user

branch_r = APIRouter(prefix="/branch", tags=["Branch"])


@branch_r.get("/", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[List[BranchSchema]])
def get_all_branch(id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_supper_admin(id=id, db=db)
    branches = BranchRepository.find_all(db, Branch)
    return ResponseSchema.from_api_route(status_code=200, data=branches).dict(exclude_none=True)


@branch_r.get("/{branch_id}", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[BranchSchema])
def get_branch_by_id(branch_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_supper_admin(id=id, db=db)
    branch = BranchRepository.find_by_id(db, Branch, branch_id)
    if not branch:
        raise HTTPException(status_code=404, detail="Branch not found")
    return ResponseSchema.from_api_route(status_code=200, data=branch).dict(exclude_none=True)


@branch_r.post("/", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[BranchSchema])
def create_branch(branch: BranchSchemaBase, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_supper_admin(id=id, db=db)
    branch_ext = BranchRepository.find_by_name(db, branch.branch_name)
    if branch_ext:
        raise HTTPException(status_code=404, detail="Branch already exist")
    branch_ct = Branch(
        branch_name=branch.branch_name,
        province=branch.province
    )
    branch_ctd = BranchRepository.insert(db, branch_ct)
    return ResponseSchema.from_api_route(status_code=201, data=branch_ctd).dict(exclude_none=True)


@branch_r.put("/{branch_id}", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[BranchSchema])
def update_branch(branch_id: int, branch: BranchSchemaBase, id: int = Depends(get_current_user),
                  db: Session = Depends(get_db)):
    check_permission_role_supper_admin(id=id, db=db)
    branch_ed = BranchRepository.find_by_id(db, Branch, branch_id)
    if not branch:
        raise HTTPException(status_code=404, detail="Branch not found")
    branch_ed.branch_name = branch.branch_name
    branch_ed.province = branch.province
    BranchRepository.update(db, branch_ed)
    return ResponseSchema.from_api_route(status_code=200, data=branch_ed).dict(exclude_none=True)


@branch_r.delete("/{branch_id}", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[str])
def delete_branch(branch_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_supper_admin(id=id, db=db)
    branch = BranchRepository.find_by_id(db, Branch, branch_id)
    if not branch:
        raise HTTPException(status_code=404, detail="Branch not found")
    BranchRepository.delete(db, branch)
    return ResponseSchema.from_api_route(status_code=200, data="Delete branch success").dict(exclude_none=True)
