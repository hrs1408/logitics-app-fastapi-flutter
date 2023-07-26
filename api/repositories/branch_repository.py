from sqlalchemy.orm import Session

from models.branch import Branch, Headquarter, Warehouse, Port
from repositories.base_repository import BaseRepository


class BranchRepository(BaseRepository):

    @staticmethod
    def find_by_name(db: Session, name):
        return db.query(Branch).filter(Branch.branch_name == name).first()

    @staticmethod
    def find_by_province(db: Session, province):
        return db.query(Branch).filter(Branch.province == province).all()


class HeadquarterRepository(BaseRepository):

    @staticmethod
    def find_by_name(db: Session, name):
        return db.query(Headquarter).filter(Headquarter.headquarter_name == name).first()

    @staticmethod
    def find_by_branch_id(db: Session, branch_id):
        return db.query(Headquarter).filter(Headquarter.branch_id == branch_id).all()


class WarehouseRepository(BaseRepository):

    @staticmethod
    def find_by_name(db: Session, name):
        return db.query(Warehouse).filter(Warehouse.warehouse_name == name).first()

    @staticmethod
    def find_by_branch_id(db: Session, branch_id):
        return db.query(Warehouse).filter(Warehouse.branch_id == branch_id).all()


class PortRepository(BaseRepository):

    @staticmethod
    def find_by_name(db: Session, name):
        return db.query(Port).filter(Port.port_name == name).first()

    @staticmethod
    def find_by_type(db: Session, type_port):
        return db.query(Port).filter(Port.type_port == type_port).all()

    @staticmethod
    def find_by_warehouse_id(db: Session, warehouse_id):
        return db.query(Port).filter(Port.warehouse_id == warehouse_id).all()
