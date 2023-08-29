from typing import List

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from config import get_db
from models.user import UserPosition
from repositories.jwt_repository import JWTBearer
from repositories.user_repository import UserPositionRepository
from schemas.schema import ResponseSchema
from schemas.user_schema import UserPositionSchema, UserPositionBase
from ultis.permission import check_permission_role_supper_admin
from ultis.security import get_current_user

position = APIRouter(prefix="/position", tags=["Position"])


@position.get("/", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[List[UserPositionSchema]])
def get_all_position(id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_supper_admin(id=id, db=db)
    positions = UserPositionRepository.find_all(db, UserPosition)
    return ResponseSchema.from_api_route(status_code=200, data=positions).dict(exclude_none=True)


@position.get("/{id}", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[UserPositionSchema])
def get_position_by_id(id: int, db: Session = Depends(get_db)):
    check_permission_role_supper_admin(id=id, db=db)
    user_position = UserPositionRepository.find_by_id(db, UserPosition, id)
    return ResponseSchema.from_api_route(status_code=200, data=user_position).dict(exclude_none=True)


@position.post("/create", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[UserPositionSchema])
def create_position(user_position: UserPositionBase, id: int = Depends(get_current_user),
                    db: Session = Depends(get_db)):
    check_permission_role_supper_admin(id=id, db=db)
    user_position = UserPositionRepository.insert(db, UserPosition(**user_position.dict()))
    return ResponseSchema.from_api_route(status_code=201, data=user_position).dict(exclude_none=True)


@position.put("/{id}", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[UserPositionSchema])
def update_position(id: int, user_position: UserPositionBase, id_user_check: int = Depends(get_current_user),
                    db: Session = Depends(get_db)):
    check_permission_role_supper_admin(id=id_user_check, db=db)
    user_position_e = UserPositionRepository.find_by_id(db, UserPosition, id)
    if not user_position_e:
        raise HTTPException(status_code=404, detail="Position not found")
    user_position_e.position_name = user_position.position_name
    UserPositionRepository.update(db, user_position_e)
    return ResponseSchema.from_api_route(status_code=200, data=user_position_e).dict(exclude_none=True)


@position.delete("/{id}", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[str])
def delete_position(id: int, id_user_check: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_supper_admin(id=id_user_check, db=db)
    user_position = UserPositionRepository.find_by_id(db, UserPosition, id)
    if not user_position:
        raise HTTPException(status_code=404, detail="Position not found")
    UserPositionRepository.delete(db, user_position)
    return ResponseSchema.from_api_route(status_code=200, data="Delete position success").dict(exclude_none=True)
