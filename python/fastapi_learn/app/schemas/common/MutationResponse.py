from pydantic import BaseModel, Field


class MutationResponse(BaseModel):
    status: str
    message: str | None = None
