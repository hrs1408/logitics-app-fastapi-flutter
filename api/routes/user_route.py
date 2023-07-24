from typing import List

from fastapi import APIRouter, Depends, HTTPException
from passlib.context import CryptContext
from sqlalchemy.orm import Session

from config import get_db
from models.user import User, UserInformation
from repositories.jwt_repository import JWTBearer
from repositories.user_repository import UserRepository, UserInformationRepository, UserAddressRepository
from schemas.schema import ResponseSchema
from schemas.user_schema import UserSchema, UserAdminCreateSchema, UserInformationSchema, UserAddressSchema
from ultis.security import get_current_user

user_route = APIRouter(
    tags=["User"],
    prefix="/user"
)

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


def check_permission(id: int, db: Session = Depends(get_db)):
    check_user = UserRepository.find_by_id(db, User, id)
    if not check_user:
        raise HTTPException(status_code=404, detail="User not found or not login")
    if check_user.user_role != "admin" and check_user.user_role != "supper_admin":
        raise HTTPException(status_code=403, detail="Permission denied")
    if not check_user.is_active or check_user.is_active is False or check_user.is_active == 0 or check_user.is_active == "0":
        raise HTTPException(status_code=403, detail="User is de-active")


@user_route.get("/", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[List[UserSchema]])
def get_all_user(id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission(id, db)
    users = UserRepository.find_all(db, User)
    return ResponseSchema.from_api_route(status_code=200, data=users).dict(exclude_none=True)


@user_route.post('/', dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[UserSchema])
def create_user(user: UserAdminCreateSchema, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission(id, db)
    is_email_already_exist = UserRepository.find_by_email(db, user.email)
    if is_email_already_exist:
        raise HTTPException(status_code=400, detail="Email already registered")
    user_ct = User(
        email=user.email,
        hashed_password=pwd_context.hash(user.password),
        user_role=user.user_role
    )
    new_user = UserRepository.insert(db, user_ct)
    user_info_ct = UserInformation(
        user_id=new_user.id,
        full_name=user.full_name,
    )
    UserInformationRepository.insert(db, user_info_ct)
    return ResponseSchema.from_api_route(status_code=200, data=new_user).dict(exclude_none=True)


@user_route.put('/de-active/{user_id}', dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[UserSchema])
def de_active_user(user_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission(id, db)
    user = UserRepository.find_by_id(db, User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user.is_active = False
    UserRepository.update(db, user)
    return ResponseSchema.from_api_route(status_code=200, data=user).dict(exclude_none=True)


@user_route.put('/active/{user_id}', dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[UserSchema])
def active_user(user_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission(id, db)
    user = UserRepository.find_by_id(db, User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user.is_active = True
    UserRepository.update(db, user)
    return ResponseSchema.from_api_route(status_code=200, data=user).dict(exclude_none=True)


@user_route.delete('/{user_id}', dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[UserSchema])
def delete_user(user_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission(id, db)
    user = UserRepository.find_by_id(db, User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    UserRepository.delete(db, user)
    return ResponseSchema.from_api_route(status_code=200, data=user).dict(exclude_none=True)


@user_route.put('/user-info/{user_id}', dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[UserSchema])
def update_user_info(user_id: int, user_info: UserInformationSchema,
                     db: Session = Depends(get_db)):
    user = UserRepository.find_by_id(db, User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user_info_db = UserInformationRepository.find_by_user_id(db, user_id)
    if not user_info_db:
        user_info_ct = UserInformation(
            user_id=user_id,
            full_name=user_info.full_name,
            phone_number=user_info.phone_number,
            date_of_birth=user_info.date_of_birth,
            identity_card_code=user_info.identity_card_code
        )
        UserInformationRepository.insert(db, user_info_ct)
        return ResponseSchema.from_api_route(status_code=200, data=user_info_ct).dict(exclude_none=True)
    else:
        user_info_db.full_name = user_info.full_name
        user_info_db.phone_number = user_info.phone_number
        user_info_db.date_of_birth = user_info.date_of_birth
        user_info_db.identity_card_code = user_info.identity_card_code
        UserInformationRepository.update(db, user_info_db)
        return ResponseSchema.from_api_route(status_code=200, data=user_info_db).dict(exclude_none=True)
