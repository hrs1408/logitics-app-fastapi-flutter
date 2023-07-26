from sqlalchemy import Integer, Column, ForeignKey, String
from sqlalchemy.orm import relationship

from database.database import Base


class Timekeeping(Base):
    __tablename__ = 'timekeeping'

    id = Column(Integer, primary_key=True, index=True)
    month = Column(Integer, nullable=False)
    year = Column(Integer, nullable=False)

    user_id = Column(Integer, ForeignKey('users.id'), nullable=False)

    user = relationship("User", back_populates="timekeeping", uselist=False)
    timekeeping_detail = relationship("TimekeepingDetail", back_populates="timekeeping", uselist=True)


class TimekeepingDetail(Base):
    __tablename__ = 'timekeeping_detail'

    id = Column(Integer, primary_key=True, index=True)
    day = Column(Integer, nullable=False)
    time_in = Column(String(255), nullable=False)
    time_out = Column(String(255), nullable=False)
    timekeeping_id = Column(Integer, ForeignKey('timekeeping.id'), nullable=False)

    timekeeping = relationship("Timekeeping", back_populates="timekeeping_detail", uselist=False)
