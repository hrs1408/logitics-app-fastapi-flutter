from sqlalchemy import String, Column, Integer, ForeignKey, Enum
from sqlalchemy.orm import relationship

from database.database import Base


class TypePort(str, Enum):
    IN = 'in'
    OUT = 'out'


class Branch(Base):
    __tablename__ = 'branches'

    id = Column(Integer, primary_key=True, index=True)
    branch_name = Column(String(255), nullable=False)
    province = Column(String(255), nullable=False)

    users = relationship("User", back_populates="branches", uselist=True)
    headquarters = relationship("Headquarter", back_populates="branch", uselist=True)
    warehouses = relationship("Warehouse", back_populates="branch", uselist=True)
    vehicles = relationship("Vehicle", back_populates="branch", uselist=True)


class Headquarter(Base):
    __tablename__ = 'headquarters'

    id = Column(Integer, primary_key=True, index=True)
    headquarter_name = Column(String(255), nullable=False)
    address = Column(String(255), nullable=False)

    branch_id = Column(Integer, ForeignKey('branches.id'), nullable=False)

    branch = relationship("Branch", back_populates="headquarters", uselist=False)
    voyages = relationship("Voyage", back_populates="headquarter", uselist=True)


class Warehouse(Base):
    __tablename__ = 'warehouses'

    id = Column(Integer, primary_key=True, index=True)
    warehouse_name = Column(String(255), nullable=False)
    address = Column(String(255), nullable=False)

    branch_id = Column(Integer, ForeignKey('branches.id'), nullable=False)

    branch = relationship("Branch", back_populates="warehouses", uselist=False)
    ports = relationship("Port", back_populates="warehouse", uselist=True)


class Port(Base):
    __tablename__ = 'ports'

    id = Column(Integer, primary_key=True, index=True)
    port_name = Column(String(255), nullable=False)
    port_type = Column(String(255), default=TypePort.IN, nullable=False)
    warehouse_id = Column(Integer, ForeignKey('warehouses.id'), nullable=False)

    warehouse = relationship("Warehouse", back_populates="ports", uselist=False)
    voyages = relationship("Voyage", back_populates="port", uselist=True)
