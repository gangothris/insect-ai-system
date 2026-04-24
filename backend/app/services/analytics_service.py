import os
import matplotlib
matplotlib.use('Agg')

import matplotlib.pyplot as plt
from app.db.database import fetch_analytics
from app.core.config import DATA_PATH

def get_analytics_data():
    data = fetch_analytics()
    return [{"insect": r[0], "count": r[1]} for r in data]

def generate_chart():
    data = fetch_analytics()

    insects = [r[0] for r in data]
    counts = [r[1] for r in data]

    os.makedirs(DATA_PATH, exist_ok=True)
    path = os.path.join(DATA_PATH, "analytics_chart.png")

    plt.figure()
    plt.bar(insects, counts)
    plt.savefig(path)
    plt.close()

    return path