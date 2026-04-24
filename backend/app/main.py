from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from app.api.api_router import api_router

app = FastAPI(title="Insect Detection API")

# 🔥 Serve images folder (VERY IMPORTANT)
app.mount("/images", StaticFiles(directory="data"), name="images")

app.include_router(api_router)

@app.get("/")
def home():
    return {"message": "API running"}