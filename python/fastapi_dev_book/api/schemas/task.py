from pydantic import BaseModel, Field


class TaskBase(BaseModel):
    title: str | None = Field(
        default=None, description="Title of the task", example="Buy groceries"
    )


class TaskCreate(TaskBase):
    pass


class TaskCreateResponse(TaskCreate):
    id: int

    class Config:
        orm_mode = True


class Task(TaskBase):
    id: int
    done: bool | None = Field(default=False, description="Task completion status")

    class Config:
        orm_mode = True
