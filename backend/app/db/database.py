import sqlite3
from app.core.config import DB_PATH

conn = sqlite3.connect(DB_PATH, check_same_thread=False)
cursor = conn.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS detections (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    image_path TEXT,
    insect_type TEXT,
    confidence REAL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
)
""")

conn.commit()

def insert_detection(image_path, insect_type, confidence):
    cursor.execute("""
    INSERT INTO detections (image_path, insect_type, confidence)
    VALUES (?, ?, ?)
    """, (image_path, insect_type, confidence))
    conn.commit()

def fetch_analytics():
    cursor.execute("""
        SELECT insect_type, COUNT(*) 
        FROM detections 
        GROUP BY insect_type
    """)
    return cursor.fetchall()