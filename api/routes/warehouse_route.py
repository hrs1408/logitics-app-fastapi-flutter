from typing import List

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from config import get_db
from models.branch import Warehouse, Branch
from repositories.branch_repository import WarehouseRepository, BranchRepository, PortRepository
from repositories.jwt_repository import JWTBearer
from schemas.branch_schema import WarehouseSchema, WarehouseBase
from schemas.schema import ResponseSchema
from ultis.permission import check_permission_role_admin
from ultis.security import get_current_user

warehouse_route = APIRouter(
    prefix="/warehouse",
    tags=["Warehouse"],
)


@warehouse_route.get("/", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[List[WarehouseSchema]])
def get_all_warehouse(id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    warehouses = WarehouseRepository.find_all(db, Warehouse)
    return ResponseSchema.from_api_route(status_code=200, data=warehouses).dict(exclude_none=True)


@warehouse_route.get("/{warehouse_id}", dependencies=[Depends(JWTBearer())],
                     response_model=ResponseSchema[WarehouseSchema])
def get_warehouse_by_id(warehouse_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    warehouse = WarehouseRepository.find_by_id(db, Warehouse, warehouse_id)
    if not warehouse:
        raise HTTPException(status_code=404, detail="Warehouse not found")
    return ResponseSchema.from_api_route(status_code=200, data=warehouse).dict(exclude_none=True)


@warehouse_route.get("{branch_id}/branch", dependencies=[Depends(JWTBearer())],
                     response_model=ResponseSchema[List[WarehouseSchema]])
def get_warehouse_by_branch_id(branch_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    branch = BranchRepository.find_by_id(db, Branch, branch_id)
    if not branch:
        raise HTTPException(status_code=404, detail="Branch not found")
    warehouses = WarehouseRepository.find_by_branch_id(db, branch_id)
    return ResponseSchema.from_api_route(status_code=200, data=warehouses).dict(exclude_none=True)


@warehouse_route.post("/{branch_id}", dependencies=[Depends(JWTBearer())],
                      response_model=ResponseSchema[WarehouseSchema])
def create_warehouse(branch_id: int, warehouse: WarehouseBase, id: int = Depends(get_current_user),
                     db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    branch = BranchRepository.find_by_id(db, Branch, branch_id)
    if not branch:
        raise HTTPException(status_code=404, detail="Branch not found")
    warehouse_est = WarehouseRepository.find_by_name(db, warehouse.warehouse_name)
    if warehouse_est:
        raise HTTPException(status_code=404, detail="Warehouse already exist")
    warehouse_ct = Warehouse(
        warehouse_name=warehouse.warehouse_name,
        address=warehouse.address,
        branch_id=branch_id
    )
    warehouse_ctd = WarehouseRepository.insert(db, warehouse_ct)
    return ResponseSchema.from_api_route(status_code=201, data=warehouse_ctd).dict(exclude_none=True)


@warehouse_route.put("/{warehouse_id}", dependencies=[Depends(JWTBearer())],
                     response_model=ResponseSchema[WarehouseSchema])
def update_warehouse(warehouse_id: int, warehouse: WarehouseBase, id: int = Depends(get_current_user),
                     db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    warehouse_ed = WarehouseRepository.find_by_id(db, Warehouse, warehouse_id)
    if not warehouse:
        raise HTTPException(status_code=404, detail="Warehouse not found")
    warehouse_ed.warehouse_name = warehouse.warehouse_name
    warehouse_ed.address = warehouse.address
    WarehouseRepository.update(db, warehouse_ed)
    return ResponseSchema.from_api_route(status_code=200, data=warehouse_ed).dict(exclude_none=True)


@warehouse_route.delete("/{warehouse_id}", dependencies=[Depends(JWTBearer())],
                        response_model=ResponseSchema[WarehouseSchema])
def delete_warehouse(warehouse_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    ports = PortRepository.find_by_warehouse_id(db, warehouse_id)
    if ports:
        raise HTTPException(status_code=404, detail="Warehouse has port")
    warehouse = WarehouseRepository.find_by_id(db, Warehouse, warehouse_id)
    if not warehouse:
        raise HTTPException(status_code=404, detail="Warehouse not found")
    WarehouseRepository.delete(db, warehouse)
    return ResponseSchema.from_api_route(status_code=200, data=warehouse).dict(exclude_none=True)
