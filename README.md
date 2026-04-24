# 🐛 Insect Detection and Recommendation System

## 📌 Overview

This project presents an intelligent insect detection system designed for agricultural applications. The system allows users to capture or upload images of plants and automatically detects harmful insects using a deep learning model. Based on the detected insects, the system provides recommendations for treatment and prevention.

The solution integrates Artificial Intelligence, backend API development, and mobile application design to create a complete end-to-end system.

---

## 🎯 Objectives

* Detect harmful insects from plant images using deep learning
* Provide actionable treatment and prevention recommendations
* Develop a user-friendly mobile application for real-world usage
* Bridge the gap between AI technology and agricultural practices

---

## 🏗️ System Architecture

The system follows a client-server architecture:

* **Frontend:** Flutter Mobile Application
* **Backend:** FastAPI (Python)
* **Model:** YOLO-based Object Detection (ONNX optimized)

### Workflow:

1. User captures or uploads an image
2. Image is sent to backend API
3. Model performs insect detection
4. Backend processes results and generates recommendations
5. Results displayed in the mobile application

---

## 🤖 Technologies Used

### 🔹 FastAPI

A high-performance Python web framework used to build REST APIs for handling image processing and communication between frontend and backend.

### 🔹 YOLO (You Only Look Once)

A real-time object detection algorithm used to detect insects with bounding boxes and classification labels.

### 🔹 ONNX (Open Neural Network Exchange)

Used to optimize the trained model for faster inference and better portability across platforms.

### 🔹 Flutter

A cross-platform UI toolkit used to build the mobile application with a responsive and modern interface.

### 🔹 OpenCV

Used for image processing tasks such as reading images and drawing bounding boxes.

### 🔹 LLM (Large Language Model)

Initially integrated for generating intelligent recommendations. Later replaced with a rule-based system to ensure stability and avoid dependency on external APIs.

---

## 📱 Application Features

* Capture image using mobile camera
* Upload image from gallery
* Detect insects with bounding box visualization
* Display insect details and recommendations
* Analytics dashboard with visual insights

---

## 📂 Project Structure

```bash id="z1wq9n"
insect-ai-system/
│
├── backend/
│   ├── app/
│   ├── data/
│   ├── model/
│   └── requirements.txt
│
├── frontend/
│   ├── lib/
│   ├── android/
│   └── pubspec.yaml
│
└── README.md
```

---

## ⚙️ Setup Instructions

### 🔧 Backend Setup

```bash id="2q4v3m"
cd backend
pip install -r requirements.txt
uvicorn app.main:app --host 0.0.0.0 --port 8000
```

---

### 📱 Frontend Setup

```bash id="i7q2ka"
cd frontend
flutter pub get
flutter run
```

---

## 📊 Results

* Accurate detection of insect species
* Real-time inference using optimized ONNX model
* Clear visualization with bounding boxes
* Smooth mobile application experience

---

## ⚠️ Limitations

* Currently supports only English language
* Performance depends on image quality
* System is demonstrated in a local environment
* Limited dataset for certain insect classes

---

## 🚀 Future Work

* Add multilingual support for farmers (regional languages)
* Deploy backend on cloud platforms (Render/AWS)
* Improve dataset and model accuracy
* Integrate advanced AI-based recommendations
* Enable real-time video detection

---

## 👨‍💻 Author

Gangothri S
B.Tech Computer Science (Data Science)  
gmail : gangothris10@gmail.com 

---

## 📌 Note

This project demonstrates the integration of deep learning, backend systems, and mobile application development to solve real-world agricultural problems.
