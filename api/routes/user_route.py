from typing import List

from fastapi import APIRouter, Depends, HTTPException
from passlib.context import CryptContext
from sqlalchemy.orm import Session

from config import get_db
from models.user import User, UserInformation
from repositories.jwt_repository import JWTBearer
from repositories.user_repository import UserRepository, UserInformationRepository, UserAddressRepository
from schemas.schema import ResponseSchema
from schemas.user_schema import UserSchema, UserAdminCreateSchema, UserInformationSchema, UserAddressSchema, \
    UserBankAccountSchema, UserInformationBase, UserAdminUpdateSchema
from ultis.permission import check_permission_role_admin
from ultis.security import get_current_user

user_route = APIRouter(
    tags=["User"],
    prefix="/user"
)

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


@user_route.get("/", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[List[UserSchema]])
def get_all_user(id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id, db)
    users = UserRepository.find_all(db, User)
    return ResponseSchema.from_api_route(status_code=200, data=users).dict(exclude_none=True)


@user_route.get("/{user_id}", dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[UserSchema])
def get_user_by_id(user_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id, db)
    user = UserRepository.find_by_id(db, User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return ResponseSchema.from_api_route(status_code=200, data=user).dict(exclude_none=True)


@user_route.post('/create', dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[UserSchema])
def create_user(user: UserAdminCreateSchema, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id, db)
    is_email_already_exist = UserRepository.find_by_email(db, user.email)
    if is_email_already_exist:
        raise HTTPException(status_code=400, detail="Email already registered")
    user_ct = User(
        email=user.email,
        hashed_password=pwd_context.hash(user.password),
        user_role=user.user_role,
        user_position_id=user.user_position_id,
    )
    new_user = UserRepository.insert(db, user_ct)
    user_info_ct = UserInformation(
        user_id=new_user.id,
        full_name=user.full_name,
    )
    UserInformationRepository.insert(db, user_info_ct)
    return ResponseSchema.from_api_route(status_code=200, data=new_user).dict(exclude_none=True)


@user_route.put('/update/{user_id}', dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[UserSchema])
def update_user(user_id: int, user: UserAdminUpdateSchema, id: int = Depends(get_current_user),
                db: Session = Depends(get_db)):
    check_permission_role_admin(id, db)
    user_db = UserRepository.find_by_id(db, User, user_id)
    if not user_db:
        raise HTTPException(status_code=404, detail="User not found")
    is_email_already_exist = UserRepository.find_by_email(db, user.email)
    if is_email_already_exist and is_email_already_exist.id != user_id:
        raise HTTPException(status_code=400, detail="Email already registered")
    user_db.email = user.email
    user_db.user_role = user.user_role
    user_db.user_position_id = user.user_position_id
    UserRepository.update(db, user_db)
    user_info_db = UserInformationRepository.find_by_user_id(db, user_id)
    user_info_db.full_name = user.full_name
    UserInformationRepository.update(db, user_info_db)
    return ResponseSchema.from_api_route(status_code=200, data=user_db).dict(exclude_none=True)


@user_route.put('/de-active/{user_id}', dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[UserSchema])
def de_active_user(user_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id, db)
    user = UserRepository.find_by_id(db, User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user.is_active = False
    UserRepository.update(db, user)
    return ResponseSchema.from_api_route(status_code=200, data=user).dict(exclude_none=True)


@user_route.put('/active/{user_id}', dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[UserSchema])
def active_user(user_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id, db)
    user = UserRepository.find_by_id(db, User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user.is_active = True
    UserRepository.update(db, user)
    return ResponseSchema.from_api_route(status_code=200, data=user).dict(exclude_none=True)


@user_route.delete('/{user_id}', dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[str])
def delete_user(user_id: int, id: int = Depends(get_current_user), db: Session = Depends(get_db)):
    check_permission_role_admin(id, db)
    user_info = UserInformationRepository.find_by_user_id(db, user_id)
    user = UserRepository.find_by_id(db, User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    if user_info:
        UserInformationRepository.delete(db, user_info)
    UserRepository.delete(db, user)
    return ResponseSchema.from_api_route(status_code=200, data="Success").dict(exclude_none=True)


@user_route.put('/user-info/{user_id}', dependencies=[Depends(JWTBearer())], response_model=ResponseSchema[UserSchema])
def update_user_info(user_id: int, user_info: UserInformationBase,
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


@user_route.post('/user-address/{user_id}', dependencies=[Depends(JWTBearer())],
                 response_model=ResponseSchema[UserAddressSchema])
def create_user_address(user_id: int, user_address: UserAddressSchema, db: Session = Depends(get_db)):
    user = UserRepository.find_by_id(db, User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user_address_ct = UserAddressRepository.insert(db, user_address)
    return ResponseSchema.from_api_route(status_code=200, data=user_address_ct).dict(exclude_none=True)


@user_route.put('/user-address/{user_id}', dependencies=[Depends(JWTBearer())],
                response_model=ResponseSchema[UserSchema])
def update_user_address(user_id: int, user_address: UserAddressSchema, db: Session = Depends(get_db)):
    user = UserRepository.find_by_id(db, User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user_address_db = UserAddressRepository.find_by_user_id(db, user_id)
    if not user_address_db:
        user_address_ct = UserAddressRepository.insert(db, user_address)
        return ResponseSchema.from_api_route(status_code=200, data=user_address_ct).dict(exclude_none=True)
    else:
        user_address_db.address = user_address.address
        user_address_db.district = user_address.district
        user_address_db.ward = user_address.ward
        user_address_db.city = user_address.city
        user_address_db.province = user_address.province
        user_address_db.sub_phone_number = user_address.sub_phone_number
        UserAddressRepository.update(db, user_address_db)
        return ResponseSchema.from_api_route(status_code=200, data=user_address_db).dict(exclude_none=True)


@user_route.get('/user-address/{user_id}', dependencies=[Depends(JWTBearer())],
                response_model=ResponseSchema[List[UserAddressSchema]])
def get_user_address(user_id: int, db: Session = Depends(get_db)):
    user = UserRepository.find_by_id(db, User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user_address = UserAddressRepository.find_all_by_user_id(db, user_id)
    return ResponseSchema.from_api_route(status_code=200, data=user_address).dict(exclude_none=True)


@user_route.delete('/user-address/{user_id}', dependencies=[Depends(JWTBearer())],
                   response_model=ResponseSchema[UserAddressSchema])
def delete_user_address(user_id: int, user_address_id: int, db: Session = Depends(get_db)):
    user = UserRepository.find_by_id(db, User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user_address = UserAddressRepository.find_by_id(db, UserAddressSchema, user_address_id)
    if not user_address:
        raise HTTPException(status_code=404, detail="User address not found")
    UserAddressRepository.delete(db, user_address)
    return ResponseSchema.from_api_route(status_code=200, data=user_address).dict(exclude_none=True)


@user_route.post('/user-bank-account/{user_id}', dependencies=[Depends(JWTBearer())],
                 response_model=ResponseSchema[UserBankAccountSchema])
def create_user_bank_account(user_id: int, user_bank_account: UserBankAccountSchema, db: Session = Depends(get_db)):
    user = UserRepository.find_by_id(db, User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user_bank_account_ct = UserAddressRepository.insert(db, user_bank_account)
    return ResponseSchema.from_api_route(status_code=200, data=user_bank_account_ct).dict(exclude_none=True)


@user_route.put('/user-bank-account/{user_id}', dependencies=[Depends(JWTBearer())],
                response_model=ResponseSchema[UserBankAccountSchema])
def update_user_bank_account(user_id: int, user_bank_account: UserBankAccountSchema, db: Session = Depends(get_db)):
    user = UserRepository.find_by_id(db, User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user_bank_account_db = UserAddressRepository.find_by_user_id(db, user_id)
    if not user_bank_account_db:
        user_bank_account_ct = UserAddressRepository.insert(db, user_bank_account)
        return ResponseSchema.from_api_route(status_code=200, data=user_bank_account_ct).dict(exclude_none=True)
    else:
        user_bank_account_db.bank_name = user_bank_account.bank_name
        user_bank_account_db.bank_account_number = user_bank_account.bank_account_number
        user_bank_account_db.bank_account_name = user_bank_account.bank_account_name
        UserAddressRepository.update(db, user_bank_account_db)
        return ResponseSchema.from_api_route(status_code=200, data=user_bank_account_db).dict(exclude_none=True)


@user_route.get('/user-bank-account/{user_id}', dependencies=[Depends(JWTBearer())],
                response_model=ResponseSchema[List[UserBankAccountSchema]])
def get_user_bank_account(user_id: int, db: Session = Depends(get_db)):
    user = UserRepository.find_by_id(db, User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user_bank_account = UserAddressRepository.find_all_by_user_id(db, user_id)
    return ResponseSchema.from_api_route(status_code=200, data=user_bank_account).dict(exclude_none=True)


@user_route.delete('/user-bank-account/{user_id}', dependencies=[Depends(JWTBearer())],
                   response_model=ResponseSchema[UserBankAccountSchema])
def delete_user_bank_account(user_id: int, user_bank_account_id: int, db: Session = Depends(get_db)):
    user = UserRepository.find_by_id(db, User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user_bank_account = UserAddressRepository.find_by_id(db, UserBankAccountSchema, user_bank_account_id)
    if not user_bank_account:
        raise HTTPException(status_code=404, detail="User bank account not found")
    UserAddressRepository.delete(db, user_bank_account)
    return ResponseSchema.from_api_route(status_code=200, data=user_bank_account).dict(exclude_none=True)
