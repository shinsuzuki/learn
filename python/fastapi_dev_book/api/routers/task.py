from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from api.schemas.task import Task, TaskCreate, TaskCreateResponse
from api.util.db import get_db_session
import api.cruds.task as cruds_task

router = APIRouter()


@router.get("/tasks", response_model=list[Task])
async def list_tasks():
    return [Task(id=1, title="Sample Task", done=False)]


@router.post("/tasks", response_model=TaskCreateResponse)
async def create_tasks(
    task_body: TaskCreate, db: AsyncSession = Depends(get_db_session)
):
    # return TaskCreateResponse(id=1, **task_body.model_dump())
    return cruds_task.create_task(task_body)


@router.put("/tasks/{task_id}", response_model=TaskCreateResponse)
async def update_tasks(task_id: int, task_body: TaskCreate):
    return TaskCreateResponse(id=task_id, **task_body.model_dump())


@router.delete("/tasks/{task_id}", response_model=None)
async def delete_tasks(task_id: int):
    pass
