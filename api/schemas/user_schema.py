from typing import Optional, List

from pydantic import BaseModel


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
