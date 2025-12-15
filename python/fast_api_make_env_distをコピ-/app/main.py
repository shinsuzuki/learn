from fastapi import FastAPI, APIRouter
from app.routers.hoge import router as hoge_router


app = FastAPI()
app.include_router(hoge_router)


@app.get("/")
async def root():
    return {"message": "Hello World"}
