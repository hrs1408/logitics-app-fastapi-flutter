from sqlalchemy.orm import Session

from models.vehicle import Vehicle
from repositories.base_repository import BaseRepository


git 
    @staticmethod
    def find_by_tonnage(db: Session, tonnage):
        return db.query(Vehicle).filter(Vehicle.tonnage == tonnage).all()

    @staticmethod
    def find_by_vehicle_type(db: Session, vehicle_type):
        return db.query(Vehicle).filter(Vehicle.vehicle_type == vehicle_type).all()

    @staticmethod
    def find_by_branch_id(db: Session, branch_id):
        return db.query(Vehicle).filter(Vehicle.branch_id == branch_id).all()
