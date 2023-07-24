from datetime import datetime
from typing import Optional

from fastapi import HTTPException
from pydantic import BaseModel, Field, root_validator


class LoginSchema(BaseModel):
    email: str = Field(..., email=True)
    password: str = Field(..., min_length=8, max_length=32)


class RegisterSchema(BaseModel):
    email: str
    full_name: str
    password: str
    confirm_password: str

    @root_validator()
    def validate_password(cls, values):
        password = values.get('password')
        confirm_password = values.get('confirm_password')
        if password != confirm_password:
            raise HTTPException(status_code=400, detail="Password and confirm password not match")
        if password is None or (len(password) == 0) or (password == ''):
            raise HTTPException(status_code=400, detail="Password is required")
        if password and len(password) < 8:
            raise HTTPException(status_code=400, detail="Password must be at least 8 characters")
        return values


class AuthResponseSchema(BaseModel):
    token_type: str
    access_token: str
    access_token_expires: datetime
    refresh_token: str
    refresh_token_expires: datetime


class AccessToken(BaseModel):
    token_type: str
    access_token: str
    access_token_expires: datetime


class RefreshToken(BaseModel):
    refresh_token: str
    refresh_token_expires: datetime
    sub: Optional[str]


class RefreshTokenRequestSchema(BaseModel):
    refresh_token: str
