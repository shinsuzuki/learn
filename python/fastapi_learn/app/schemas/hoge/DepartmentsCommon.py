from pydantic import BaseModel, Field


class Department(BaseModel):
    department_id: int = Field(description="部署ID")
    department_name: str = Field(description="部署名")
    location: str = Field(description="勤務地")
    model_config = {"from_attributes": True}  # これを追加
