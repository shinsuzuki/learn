from sqlalchemy import Column, Integer, String, DateTime, Boolean
from app.utils.db.database import Base


class DepartmentsModel(Base):
    """
    Departmentsモデル
    """

    __tablename__ = "departments"
    #
    department_id = Column(Integer, primary_key=True)
    department_name = Column(String(30), nullable=False)
    location = Column(String(50), nullable=True)
