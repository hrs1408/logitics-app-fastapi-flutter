from typing import Optional, List

from fastapi import HTTPException
from pydantic import BaseModel, root_validator


class UserInformationBase(BaseModel):
    full_name: str
    phone_number: Optional[str]
    date_of_birth: Optional[str]
    identity_card_code: Optional[str]


class UserInformationSchema(UserInformationBase):
    id: int
    user_id: int

    class Config:
        orm_mode = True


class UserAddressBase(BaseModel):
    address: str
    district: Optional[str]
    ward: Optional[str]
    city: Optional[str]
    province: Optional[str]
    sub_phone_number: Optional[str]


class UserAddressSchema(UserAddressBase):
    id: int
    user_id: int

    class Config:
        orm_mode = True


class UserBankAccountBase(BaseModel):
    bank_name: str
    bank_account_number: str
    bank_account_name: str


class UserBankAccountSchema(UserBankAccountBase):
    id: int
    user_id: int

    class Config:
        orm_mode = True


class UserSchema(BaseModel):
    email: str
    hashed_password: str
    user_role: str
    is_active: bool
    refresh_token_sub: Optional[str]
    user_information: Optional[UserInformationSchema]
    user_address: Optional[List[UserAddressSchema]]
    user_bank_account: Optional[List[UserBankAccountSchema]]

    class Config:
        orm_mode = True


class UserAdminCreateSchema(BaseModel):
    email: str
    full_name: str
    password: str
    confirm_password: str
    user_role: str

    @root_validator()
    def validate_password(cls, values):
        password = values.get('password')
        confirm_password = values.get('confirm_password')
        if (password != confirm_password):
            raise HTTPException(status_code=400, detail="Password and confirm password not match")
        if password is None or (len(password) == 0) or (password == ''):
            raise HTTPException(status_code=400, detail="Password is required")
        if password and len(password) < 8:
            raise HTTPException(status_code=400, detail="Password must be at least 8 characters")
        return values

