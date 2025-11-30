from sqlalchemy import Column, Integer, String, DateTime, Boolean
from app.utils.db.database import Base


class EmployeesModel(Base):
    """
    Employeesモデル
    """

    __tablename__ = "employees"
    #
    employee_id = Column(Integer, primary_key=True)
    # employee_id = Column(Integer, primary_key=True, index=True)
    last_name = Column(String(25), nullable=False)
    first_name = Column(String(25), nullable=True)
    salary = Column(Integer, nullable=True)
    department_id = Column(Integer, nullable=True)
