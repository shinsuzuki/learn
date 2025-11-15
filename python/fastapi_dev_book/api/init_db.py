import os
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from models.task import Base
import asyncio

base_dir = os.path.dirname(__file__)
DATABASE_URL = "sqlite+aiosqlite:///" + os.path.join(base_dir, "app.db")
engine = create_async_engine(DATABASE_URL, echo=True)


async def init_db():
    async with engine.begin() as conn:
        print("start initial db")
        await conn.run_sync(Base.metadata.drop_all)
        print("delete db")
        await conn.run_sync(Base.metadata.create_all)
        print("create db")


if __name__ == "__main__":
    asyncio.run(init_db())
