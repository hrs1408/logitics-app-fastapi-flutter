from enum import Enum

from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship

from database.database import Base


class UserRole(str, Enum):
    SUPPER_ADMIN = 'supper_admin'
    ADMIN = 'admin'
    USER = 'user'
    CLIENT = 'client'


class UserPosition(str, Enum):
    ROOT = 'root'
    BRANCH_MANAGER = 'branch_manager'
    WAREHOUSE_STAFF = 'warehouse_staff'
    DRIVER_STAFF = 'driver_staff'
    DELIVERY_STAFF = 'delivery_staff'
    CLIENT = 'client'


class UserPosition(Base):
    __tablename__ = 'user_position'

    id = Column(Integer, primary_key=True, index=True)
    position_name = Column(String(255), default=UserPosition.CLIENT, nullable=False)

    users = relationship("User", back_populates="user_position", uselist=True)


class User(Base):
    __tablename__ = 'users'
    __table_args__ = {'extend_existing': True}

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String(255), unique=True, index=True)
    hashed_password = Column(String(255))
    user_role = Column(String(255), default=UserRole.CLIENT, nullable=False)
    user_position_id = Column(Integer, ForeignKey('user_position.id'), default=2)
    is_active = Column(String(255), default=True, nullable=False)
    refresh_token_sub = Column(String(255), nullable=True)

    user_position = relationship("UserPosition", back_populates="users", uselist=False)
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
