from fastapi import APIRouter, UploadFile, File
from app.services.inference_service import run_inference, draw_boxes
from app.services.recommendation_service import generate_recommendation
from app.utils.image_utils import read_image
from app.core.config import DATA_PATH

from collections import Counter
from datetime import datetime
import os
import cv2

router = APIRouter()

# 🔥 SET YOUR LOCAL IP HERE
BASE_URL = "http://10.105.167.194:8000"

@router.post("/")
async def recommend(file: UploadFile = File(...)):
    contents = await file.read()

    # Read image
    image = read_image(contents)

    # Run detection
    detections = run_inference(image)

    # Stats
    count = len(detections)
    avg_conf = (
        sum([d["confidence"] for d in detections]) / count
        if count else 0
    )

    # Dominant insect
    insects = [d["class"] for d in detections]
    most_common = Counter(insects).most_common(1)[0][0] if insects else None

    # Rule-based severity
    if count > 10:
        severity = "high"
    elif count > 3:
        severity = "medium"
    else:
        severity = "low"

    # LLM recommendation
    recommendation = generate_recommendation(
        detections, count, avg_conf, severity
    )

    # 🔥 Draw bounding boxes
    annotated_image = draw_boxes(image.copy(), detections)

    # Save image
    os.makedirs(DATA_PATH, exist_ok=True)
    filename = f"{datetime.now().timestamp()}_annotated.jpg"
    image_path = os.path.join(DATA_PATH, filename)

    cv2.imwrite(image_path, annotated_image)

    return {
        "summary": {
            "total_detections": count,
            "dominant_insect": most_common,
            "avg_confidence": round(avg_conf, 3)
        },
        "recommendation": recommendation,
        # 🔥 MOBILE ACCESSIBLE URL
        "annotated_image": f"{BASE_URL}/images/{filename}"
    }