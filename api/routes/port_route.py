from typing import List

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from config import get_db
from models.branch import Warehouse, Port
from repositories.branch_repository import PortRepository, WarehouseRepository
from repositories.jwt_repository import JWTBearer
from schemas.branch_schema import PortSchema, PortBase
from schemas.schema import ResponseSchema
from ultis.permission import check_permission_role_admin
from ultis.security import get_current_user

port_route = APIRouter(
    prefix="/port",
    tags=["Port"],
)


@port_route.get("/", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[List[PortSchema]])
def get_all_port(id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    ports = PortRepository.find_all(db, Port)
    return ResponseSchema.from_api_route(status_code=200, data=ports).dict(exclude_none=True)


@port_route.get("/{port_id}", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[PortSchema])
def get_port_by_id(port_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    port = PortRepository.find_by_id(db, Port, port_id)
    if not port:
        raise HTTPException(status_code=404, detail="Port not found")
    return ResponseSchema.from_api_route(status_code=200, data=port).dict(exclude_none=True)


@port_route.post("/warehouse/{warehouse_id}", dependencies=[Depends(JWTBearer())],
                 response_model=ResponseSchema[PortSchema])
def create_port(warehouse_id: int, port: PortBase, id: int = Depends(get_current_user),
                db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    warehouse = WarehouseRepository.find_by_id(db, Warehouse, warehouse_id)
    if not warehouse:
        raise HTTPException(status_code=404, detail="Warehouse not found")
    if port.port_type != "in" and port.port_type != "out":
        raise HTTPException(status_code=400, detail="Type port must be in or out")
    port_ext = PortRepository.find_by_name(db, port.port_name)
    if port_ext:
        raise HTTPException(status_code=404, detail="Port already exist")
    port_ct = Port(
        port_name=port.port_name,
        port_type=port.port_type,
        warehouse_id=warehouse_id
    )
    port_ctd = PortRepository.insert(db, port_ct)
    return ResponseSchema.from_api_route(status_code=201, data=port_ctd).dict(exclude_none=True)


@port_route.put("/{port_id}", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[PortSchema])
def update_port(port_id: int, port: PortBase, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    if port.port_type != "in" and port.port_type != "out":
        raise HTTPException(status_code=400, detail="Type port must be in or out")
    port_ed = PortRepository.find_by_id(db, Port, port_id)
    if not port_ed:
        raise HTTPException(status_code=404, detail="Port not found")
    port_ed.port_name = port.port_name
    port_ed.port_type = port.port_type
    PortRepository.update(db, port_ed)
    return ResponseSchema.from_api_route(status_code=200, data=port_ed).dict(exclude_none=True)


@port_route.delete("/{port_id}", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[PortSchema])
def delete_port(port_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    port = PortRepository.find_by_id(db, Port, port_id)
    if not port:
        raise HTTPException(status_code=404, detail="Port not found")
    PortRepository.delete(db, port)
    return ResponseSchema.from_api_route(status_code=200, data=port).dict(exclude_none=True)


@port_route.get("/warehouse/{warehouse_id}", dependencies=[Depends(JWTBearer())],
                response_model=ResponseSchema[List[PortSchema]])
def get_port_by_warehouse_id(warehouse_id: int, db: Session = Depends(get_db)):
    ports = PortRepository.find_by_warehouse_id(db, warehouse_id)
    return ResponseSchema.from_api_route(status_code=200, data=ports).dict(exclude_none=True)
