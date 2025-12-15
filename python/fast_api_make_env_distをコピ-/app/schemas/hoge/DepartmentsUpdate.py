from pydantic import BaseModel, Field


class DepartmentUpdate(BaseModel):
    department_id: int = Field(..., description="ID")
    department_name: str = Field(..., description="部署名")
    location: str = Field(..., description="地域")
