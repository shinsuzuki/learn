from sqlalchemy import Column, Integer, String, select, ForeignKey
from sqlalchemy.orm import relationship
from api.util.db import Base


class Task(Base):
    # テーブル名
    __tablename__ = "tasks"
    id = Column(Integer, primary_key=True)
    title = Column(String(1024))

    # done = relationship("Done", back_populates="tasks", cascade="delete")


# class Done(Base):
# __tablename__ = "dones"
# id = Column(Integer, ForeignKey("tasks.id"), primary_key=True)
# task = relationship("Task", back_populates="dones")
