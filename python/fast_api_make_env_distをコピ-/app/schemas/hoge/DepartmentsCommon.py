from pydantic import BaseModel, Field


class Department(BaseModel):
    department_id: int
    department_name: str
    location: str
    model_config = {"from_attributes": True}  # これを追加
