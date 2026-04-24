from fastapi import APIRouter, UploadFile, File
from fastapi.responses import JSONResponse
from app.services.inference_service import run_inference
from app.utils.image_utils import read_image
from app.db.database import insert_detection
from app.core.config import DATA_PATH

import os
import cv2
from datetime import datetime

router = APIRouter()

@router.post("/")
async def predict(file: UploadFile = File(...)):
    contents = await file.read()

    image = read_image(contents)
    detections = run_inference(image)

    os.makedirs(DATA_PATH, exist_ok=True)
    filename = os.path.join(DATA_PATH, f"{datetime.now().timestamp()}.jpg")
    cv2.imwrite(filename, image)

    for d in detections:
        insert_detection(filename, d["class"], d["confidence"])

    return JSONResponse({
        "detections": detections,
        "count": len(detections),
        "image_saved": filename
    })