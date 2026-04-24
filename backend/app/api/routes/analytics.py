from fastapi import APIRouter
from fastapi.responses import FileResponse
from app.services.analytics_service import get_analytics_data, generate_chart

router = APIRouter()

@router.get("/")
def analytics():
    return {"analytics": get_analytics_data()}

@router.get("/chart")
def chart():
    path = generate_chart()
    return FileResponse(path)