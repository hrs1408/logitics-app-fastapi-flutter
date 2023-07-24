from enum import Enum

from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship

from database.database import Base


class UserRole(str, Enum):
    SUPPER_ADMIN = 'supper_admin'
    ADMIN = 'admin'
    USER = 'user'
    CLIENT = 'client'


class User(Base):
    __tablename__ = 'users'
    __table_args__ = {'extend_existing': True}

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String(255), unique=True, index=True)
    hashed_password = Column(String(255))
    user_role = Column(String(255), default=UserRole.CLIENT, nullable=False)
    is_active = Column(String(255), default=True, nullable=False)
    refresh_token_sub = Column(String(255), nullable=True)

    user_information = relationship("UserInformation", back_populates="user", uselist=False)
    user_address = relationship("UserAddress", back_populates="user", uselist=True)
    user_bank_account = relationship("UserBankAccount", back_populates="user", uselist=True)


class UserInformation(Base):
    __tablename__ = 'user_information'

    id = Column(Integer, primary_key=True, index=True)
    full_name = Column(String(255), nullable=False)
    phone_number = Column(String(255), default="", nullable=True)
    date_of_birth = Column(String(255), default="", nullable=True)
    identity_card_code = Column(String(255), default="", nullable=True)

    user_id = Column(Integer, ForeignKey('users.id'))

    user = relationship('User', back_populates='user_information')


class UserAddress(Base):
    __tablename__ = 'user_address'

    id = Column(Integer, primary_key=True, index=True)
    address = Column(String(255), default="", nullable=False)
    district = Column(String(255), default="", nullable=True)
    ward = Column(String(255), default="", nullable=True)
    city = Column(String(255), default="", nullable=True)
    province = Column(String(255), default="", nullable=True)
    sub_phone_number = Column(String(255), default="", nullable=True)

    user_id = Column(Integer, ForeignKey('users.id'))

    user = relationship('User', back_populates='user_address')


class UserBankAccount(Base):
    __tablename__ = 'user_bank_account'

    id = Column(Integer, primary_key=True, index=True)
    bank_name = Column(String(255), default="", nullable=False)
    bank_account_number = Column(String(255), default="", nullable=False)
    bank_account_name = Column(String(255), default="", nullable=False)

    user_id = Column(Integer, ForeignKey('users.id'))

    user = relationship('User', back_populates='user_bank_account')
