import os
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

Base = declarative_base()

base_dir = os.path.dirname(__file__)
DATABASE_URL = "sqlite+aiosqlite:///" + os.path.join(base_dir, "app.db")

engine = create_async_engine(DATABASE_URL, echo=True)
db_session = sessionmaker(bind=engine, class_=AsyncSession, expire_on_commit=False)


async def get_db_session():
    async with db_session() as session:
        yield session
