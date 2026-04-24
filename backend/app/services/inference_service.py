from ultralytics import YOLO
from app.core.config import MODEL_PATH
import cv2

# 🔥 Load ONNX model
model = YOLO(MODEL_PATH, task="detect")

# ✅ MAIN INFERENCE FUNCTION (THIS WAS MISSING)
def run_inference(image):
    results = model(image, imgsz=1024, device="cpu")

    detections = []
    class_names = model.names

    for r in results:
        for box in r.boxes:
            cls_id = int(box.cls[0])
            conf = float(box.conf[0])
            xyxy = box.xyxy[0].tolist()

            detections.append({
                "class": class_names[cls_id],
                "confidence": round(conf, 3),
                "bbox": [round(x, 2) for x in xyxy]
            })

    return detections


# ✅ DRAW BOUNDING BOXES
def draw_boxes(image, detections):
    for d in detections:
        x1, y1, x2, y2 = map(int, d["bbox"])

        label = f'{d["class"]} {d["confidence"]}'

        cv2.rectangle(image, (x1, y1), (x2, y2), (0, 255, 0), 2)

        cv2.putText(
            image,
            label,
            (x1, y1 - 5),
            cv2.FONT_HERSHEY_SIMPLEX,
            0.5,
            (0, 255, 0),
            2
        )

    return image