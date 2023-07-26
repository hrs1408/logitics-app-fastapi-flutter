from typing import List

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from config import get_db
from models.branch import Warehouse, Port
from repositories.branch_repository import PortRepository, WarehouseRepository
from repositories.jwt_repository import JWTBearer
from schemas.branch_schema import PortSchema
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
    ports = PortRepository.find_all(db)
    return ResponseSchema.from_api_route(status_code=200, data=ports).dict(exclude_none=True)


@port_route.get("/{port_id}", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[PortSchema])
def get_port_by_id(port_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    port = PortRepository.find_by_id(db, port_id)
    if not port:
        return ResponseSchema.from_api_route(status_code=404, data="Port not found").dict(exclude_none=True)
    return ResponseSchema.from_api_route(status_code=200, data=port).dict(exclude_none=True)


@port_route.post("/", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[PortSchema])
def create_port(port: PortSchema, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    warehouse = WarehouseRepository.find_by_id(db, Warehouse, port.warehouse_id)
    if not warehouse:
        return ResponseSchema.from_api_route(status_code=404, data="Warehouse not found").dict(exclude_none=True)
    if port.type_port != "in" and port.type_port != "out":
        return ResponseSchema.from_api_route(status_code=400, data="Type port must be in or out").dict(
            exclude_none=True)
    port = PortRepository.find_by_name(db, port.port_name)
    if port:
        return ResponseSchema.from_api_route(status_code=400, data="Port already exist").dict(exclude_none=True)
    port = PortRepository.insert(db, port)
    return ResponseSchema.from_api_route(status_code=201, data=port).dict(exclude_none=True)


@port_route.put("/{port_id}", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[PortSchema])
def update_port(port_id: int, port: PortSchema, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    warehouse = WarehouseRepository.find_by_id(db, Warehouse, port.warehouse_id)
    if not warehouse:
        return ResponseSchema.from_api_route(status_code=404, data="Warehouse not found").dict(exclude_none=True)
    if port.type_port != "in" and port.type_port != "out":
        return ResponseSchema.from_api_route(status_code=400, data="Type port must be in or out").dict(
            exclude_none=True)
    port_ed = PortRepository.find_by_id(db, Port, port_id)
    if not port_ed:
        return ResponseSchema.from_api_route(status_code=404, data="Port not found").dict(exclude_none=True)
    port_ed.port_name = port.port_name
    port_ed.type_port = port.type_port
    port_ed.warehouse_id = port.warehouse_id
    PortRepository.update(db, port_ed)
    return ResponseSchema.from_api_route(status_code=200, data=port_ed).dict(exclude_none=True)


@port_route.delete("/{port_id}", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[PortSchema])
def delete_port(port_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    port = PortRepository.find_by_id(db, Port, port_id)
    if not port:
        return ResponseSchema.from_api_route(status_code=404, data="Port not found").dict(exclude_none=True)
    PortRepository.delete(db, port)
    return ResponseSchema.from_api_route(status_code=200, data=port).dict(exclude_none=True)
