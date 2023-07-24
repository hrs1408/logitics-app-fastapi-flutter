from sqlalchemy.orm import Session

from models.user import User
from repositories.base_repository import BaseRepository


class UserRepository(BaseRepository):
    @staticmethod
    def find_by_email(db: Session, email):
        return db.query(User).filter(User.email == email).first()

    @staticmethod
    def find_by_role(db: Session, role):
        return db.query(User).filter(User.user_role == role).all()

    @staticmethod
    def find_by_refresh_token_sub(db: Session, sub):
        return db.query(User).filter(User.refresh_token_sub == sub).first()


class UserInformationRepository(BaseRepository):
    @staticmethod
    def find_by_user_id(db: Session, user_id):
        return db.query(User).filter(User.id == user_id).first()


class UserAddressRepository(BaseRepository):
    @staticmethod
    def find_by_user_id(db: Session, user_id):
        return db.query(User).filter(User.id == user_id).first()


class UserBankAccountRepository(BaseRepository):
    @staticmethod
    def find_by_user_id(db: Session, user_id):
        return db.query(User).filter(User.id == user_id).first()
