from sqlalchemy.orm import Session

from models.invoice import Voyage, Invoice
from repositories.base_repository import BaseRepository


class VoyageRepository(BaseRepository):

    @staticmethod
    def find_by_delivery_status(db: Session, delivery_status):
        return db.query(Voyage).filter(Voyage.delivery_status == delivery_status).all()

    @staticmethod
    def find_by_headquarter_id(db: Session, headquarter_id):
        return db.query(Voyage).filter(Voyage.headquarter_id == headquarter_id).all()

    @staticmethod
    def find_by_port_id(db: Session, port_id):
        return db.query(Voyage).filter(Voyage.port_id == port_id).all()


class InvoiceRepository(BaseRepository):

    @staticmethod
    def find_by_user_id(db: Session, user_id):
        return db.query(Invoice).filter(Invoice.user_id == user_id).all()

    @staticmethod
    def find_by_shipping_type(db: Session, shipping_type):
        return db.query(Invoice).filter(Invoice.shipping_type == shipping_type).all()

    @staticmethod
    def find_by_kind_of_goods(db: Session, kind_of_goods):
        return db.query(Invoice).filter(Invoice.kind_of_goods == kind_of_goods).all()

    @staticmethod
    def find_by_payment(db: Session, payment):
        return db.query(Invoice).filter(Invoice.payment == payment).all()

    @staticmethod
    def find_by_show_goods(db: Session, show_goods):
        return db.query(Invoice).filter(Invoice.show_goods == show_goods).all()

    @staticmethod
    def find_by_paided(db: Session, paided):
        return db.query(Invoice).filter(Invoice.paided == paided).all()
