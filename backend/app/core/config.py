from pathlib import Path
import os
from dotenv import load_dotenv

load_dotenv()

BASE_DIR = Path(__file__).resolve().parent.parent.parent

MODEL_PATH = str(BASE_DIR / "model" / "best.onnx")  # 🔥 ONNX
DATA_PATH = str(BASE_DIR / "data")
DB_PATH = str(BASE_DIR / "insect_data.db")

GROQ_API_KEY = os.getenv("GROQ_API_KEY")