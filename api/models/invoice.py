from sqlalchemy import Enum, Column, Integer, ForeignKey, String
from sqlalchemy.orm import relationship

from database.database import Base


class Payment(str, Enum):
    PAYMENT_SENDER = 'payment_sender'
    PAYMENT_RECEIVER = 'payment_receiver'


class ShowGoods(str, Enum):
    DSTG = 'dstg'
    STG = 'stg'
    TTG = 'ttg'


class ShippingType(str, Enum):
    FAST = 'fast'
    NORMAL = 'normal'
    SLOW = 'slow'


class KindOfGoods(str, Enum):
    DOCUMENT = 'document'
    FOOD = 'food'
    OTHER = 'other'


class DeliveryStatus(str, Enum):
    CREATED = 'created'
    SHIPPING = 'shipping'
    DELIVERED = 'delivered'
    CANCELED = 'canceled'


class Invoice(Base):
    __tablename__ = 'invoices'

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey('users.id'), nullable=False)
    user_address_id = Column(Integer, ForeignKey('user_address.id'), nullable=False)
    rcv_full_name = Column(String(255), nullable=False)
    rcv_phone_number = Column(String(255), nullable=False)
    rcv_address = Column(String(255), nullable=False)
    rcv_ward = Column(String(255), nullable=False)
    rcv_province = Column(String(255), nullable=False)
    shipping_type = Column(String(255), default=ShippingType.NORMAL, nullable=False)
    weight = Column(Integer, nullable=False)
    quantity = Column(Integer, nullable=False)
    commodity_value = Column(Integer, nullable=False)
    length = Column(Integer, nullable=False)
    width = Column(Integer, nullable=False)
    height = Column(Integer, nullable=False)
    cod_money = Column(Integer, nullable=False)
    kind_of_goods = Column(String(255), default=KindOfGoods.OTHER, nullable=False)
    payment = Column(String(255), default=Payment.PAYMENT_SENDER, nullable=False)
    show_goods = Column(String(255), default=ShowGoods.DSTG, nullable=False)
    requirement_other = Column(String(255), default="", nullable=True)
    paided = Column(String(255), default=False, nullable=False)

    user_address = relationship("UserAddress", back_populates="invoices", uselist=False)
    voyages = relationship("Voyage", back_populates="invoice", uselist=False)
    user = relationship("User", back_populates="invoices", uselist=False)


class Voyage(Base):
    __tablename__ = 'voyages'

    id = Column(Integer, primary_key=True, index=True)
    headquarter_id = Column(Integer, ForeignKey('headquarters.id'), nullable=False)
    invoice_id = Column(Integer, ForeignKey('invoices.id'), nullable=False)
    port_id = Column(Integer, ForeignKey('ports.id'), nullable=False)
    delivery_status = Column(String(255), default=DeliveryStatus.CREATED, nullable=False)
    pickup_staff_id = Column(Integer, ForeignKey('users.id'), nullable=True)
    delivery_staff_id = Column(Integer, ForeignKey('users.id'), nullable=True)
    vehicle_id = Column(Integer, ForeignKey('vehicles.id'), nullable=True)
    
    invoice = relationship("Invoice", back_populates="voyages", uselist=False)
    port = relationship("Port", back_populates="voyages", uselist=False)
    headquarter = relationship("Headquarter", back_populates="voyages", uselist=False)
    pickup_staff = relationship("User", foreign_keys=[pickup_staff_id], back_populates="pickup_voyages", uselist=False)
    delivery_staff = relationship("User", foreign_keys=[delivery_staff_id], back_populates="delivery_voyages",
                                  uselist=False)
    vehicle = relationship("Vehicle", back_populates="voyages", uselist=False)
