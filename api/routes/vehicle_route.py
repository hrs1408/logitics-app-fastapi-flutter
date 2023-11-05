from typing import List

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from config import get_db
from models.branch import Branch
from models.vehicle import Vehicle
from repositories.branch_repository import BranchRepository
from repositories.jwt_repository import JWTBearer
from repositories.vehicle_repository import VehicleRepository
from schemas.schema import ResponseSchema
from schemas.vehicle_schema import VehicleSchema, VehicleBase
from ultis.permission import check_permission_role_admin
from ultis.security import get_current_user

vehicle_route = APIRouter(
    prefix="/vehicle",
    tags=["Vehicle"],
)


@vehicle_route.get("/", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[List[VehicleSchema]])
def get_all_vehicle(db: Session = Depends(get_db)):
    vehicles = VehicleRepository.find_all(db, Vehicle)
    return ResponseSchema.from_api_route(status_code=200, data=vehicles).dict(exclude_none=True)


@vehicle_route.get("/{vehicle_id}", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[VehicleSchema])
def get_vehicle_by_id(vehicle_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    vehicle = VehicleRepository.find_by_id(db, Vehicle, vehicle_id)
    if not vehicle:
        raise HTTPException(status_code=404, detail="User not found")
    return ResponseSchema.from_api_route(status_code=200, data=vehicle).dict(exclude_none=True)


@vehicle_route.post("/branch/{branch_id}", dependencies=[Depends(JWTBearer())],
                    response_model=ResponseSchema[VehicleSchema])
def create_vehicle(branch_id: int, vehicle: VehicleBase, id: int = Depends(get_current_user),
                   db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    if vehicle.vehicle_type != "truck" and vehicle.vehicle_type != "car" and vehicle.vehicle_type != "motorbike":
        raise HTTPException(status_code=404, detail="Vehicle type must be truck or car or motorbike")
    branch = BranchRepository.find_by_id(db, Branch, branch_id)
    if not branch:
        raise HTTPException(status_code=404, detail="Branch not found")
    vehicle_ct = Vehicle(
        tonnage=vehicle.tonnage,
        vehicle_type=vehicle.vehicle_type,
        branch_id=branch_id,
        statusOfVehicle=vehicle.statusOfVehicle,
        currentTonage=vehicle.currentTonage
    )
    vehicle_ctd = VehicleRepository.insert(db, vehicle_ct)
    return ResponseSchema.from_api_route(status_code=201, data=vehicle_ctd).dict(exclude_none=True)


@vehicle_route.put("/{vehicle_id}", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[VehicleSchema])
def update_vehicle(vehicle_id: int, vehicle: VehicleBase, id: int = Depends(get_current_user),
                   db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    if vehicle.vehicle_type != "truck" and vehicle.vehicle_type != "car" and vehicle.vehicle_type != "motorbike":
        raise HTTPException(status_code=404, detail="Vehicle type must be truck or car or motorbike")
    vehicle_ed = VehicleRepository.find_by_id(db, Vehicle, vehicle_id)
    if not vehicle_ed:
        raise HTTPException(status_code=404, detail="Vehicle not found")
    vehicle_ed.tonnage = vehicle.tonnage
    vehicle_ed.vehicle_type = vehicle.vehicle_type
    VehicleRepository.update(db, vehicle_ed)
    return ResponseSchema.from_api_route(status_code=200, data=vehicle_ed).dict(exclude_none=True)


@vehicle_route.delete("/{vehicle_id}", dependencies=[Depends(JWTBearer())],
                      response_model=ResponseSchema[VehicleSchema])
def delete_vehicle(vehicle_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    vehicle = VehicleRepository.find_by_id(db, Vehicle, vehicle_id)
    if not vehicle:
        raise HTTPException(status_code=404, detail="Vehicle not found")
    VehicleRepository.delete(db, vehicle)
    return ResponseSchema.from_api_route(status_code=200, data=vehicle).dict(exclude_none=True)


@vehicle_route.get("/by-branch/{branch_id}", dependencies=[Depends(JWTBearer())],
                   response_model=ResponseSchema[List[VehicleSchema]])
def get_vehicle_by_branch_id(branch_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id=id, db=db)
    vehicles = VehicleRepository.find_by_branch_id(db, branch_id)
    if not vehicles:
        raise HTTPException(status_code=404, detail="Vehicle not found")
    return ResponseSchema.from_api_route(status_code=200, data=vehicles).dict(exclude_none=True)

