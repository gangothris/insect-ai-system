from pydantic import BaseModel

class Recommendation(BaseModel):
    message: str