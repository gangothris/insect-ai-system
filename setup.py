import os

# Root folder
BASE_DIR = "backend"

# Folder structure
folders = [
    "app",
    "app/core",
    "app/api",
    "app/api/routes",
    "app/services",
    "app/db",
    "app/utils",
    "app/schemas",
    "model",
    "data"
]

# Files to create
files = {
    "app/main.py": "",
    "app/core/config.py": "",
    "app/api/api_router.py": "",
    "app/api/routes/predict.py": "",
    "app/api/routes/analytics.py": "",
    "app/api/routes/recommend.py": "",
    "app/services/inference_service.py": "",
    "app/services/analytics_service.py": "",
    "app/services/recommendation_service.py": "",
    "app/db/database.py": "",
    "app/utils/image_utils.py": "",
    "app/schemas/predict_schema.py": "",
    "app/schemas/recommend_schema.py": "",
    "requirements.txt": "",
    ".env": ""
}

def create_structure():
    # Create folders
    for folder in folders:
        path = os.path.join(BASE_DIR, folder)
        os.makedirs(path, exist_ok=True)

        # create __init__.py in each folder (important for imports)
        init_file = os.path.join(path, "__init__.py")
        open(init_file, "a").close()

    # Create files
    for file_path, content in files.items():
        full_path = os.path.join(BASE_DIR, file_path)
        with open(full_path, "w") as f:
            f.write(content)

    print("✅ Backend structure created successfully!")

if __name__ == "__main__":
    create_structure()