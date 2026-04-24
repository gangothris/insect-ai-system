from fastapi import APIRouter
from app.api.routes import predict, analytics, recommend

api_router = APIRouter()

api_router.include_router(predict.router, prefix="/predict")
api_router.include_router(analytics.router, prefix="/analytics")
api_router.include_router(recommend.router, prefix="/recommend")