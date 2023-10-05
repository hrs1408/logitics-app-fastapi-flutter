from sqlalchemy import Enum, Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship

from database.database import Base


class VehicleType(str, Enum):
    TRUCK = 'truck'
    CAR = 'car'
    MOTORBIKE = 'motorbike'


class Vehicle(Base):
    __tablename__ = 'vehicles'

    id = Column(Integer, primary_key=True, index=True)
    tonnage = Column(Integer, nullable=False)
    vehicle_type = Column(String(255), default=VehicleType.TRUCK, nullable=False)
    branch_id = Column(Integer, ForeignKey('branches.id'), nullable=False)

    users = relationship("User", back_populates="vehicles", uselist=True)
    branch = relationship("Branch", back_populates="vehicles", uselist=False)
    voyages = relationship("Voyage", back_populates="vehicle", uselist=False)