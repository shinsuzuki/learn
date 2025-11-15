from sqlalchemy.ext.asyncio import AsyncSession
from api.schemas.task import Task, TaskCreate, TaskCreateResponse


async def create_task(db: AsyncSession, task_create: TaskCreate) -> TaskCreateResponse:
    task = Task(title=task_create.title)
    db.add(task)
    await db.commit()
    await db.refresh(task)
    return task
