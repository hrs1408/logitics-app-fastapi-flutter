from sqlalchemy.orm import Session

from models.timekeeping import Timekeeping, TimekeepingDetail
from repositories.base_repository import BaseRepository


class TimekeepingRepository(BaseRepository):

    @staticmethod
    def find_by_month(db: Session, month):
        return db.query(Timekeeping).filter(Timekeeping.month == month).all()

    @staticmethod
    def find_by_year(db: Session, year):
        return db.query(Timekeeping).filter(Timekeeping.year == year).all()

    @staticmethod
    def find_by_user_id(db: Session, user_id):
        return db.query(Timekeeping).filter(Timekeeping.user_id == user_id).all()

    @staticmethod
    def find_by_user_id_and_month(db: Session, user_id, month):
        return db.query(Timekeeping).filter(Timekeeping.user_id == user_id, Timekeeping.month == month).all()

    @staticmethod
    def find_by_user_id_and_month_and_year(db: Session, user_id, month, year):
        return db.query(Timekeeping).filter(Timekeeping.user_id == user_id, Timekeeping.month == month,
                                            Timekeeping.year == year).first()


class TimekeepingDetailRepository(BaseRepository):

    @staticmethod
    def find_by_timekeeping_id(db: Session, timekeeping_id):
        return db.query(TimekeepingDetail).filter(TimekeepingDetail.timekeeping_id == timekeeping_id).all()

    @staticmethod
    def find_by_timekeeping_id_and_day(db: Session, timekeeping_id, day):
        return db.query(TimekeepingDetail).filter(TimekeepingDetail.timekeeping_id == timekeeping_id,
                                                  TimekeepingDetail.day == day).first()
