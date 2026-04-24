from groq import Groq
from app.core.config import GROQ_API_KEY
import json

client = Groq(api_key=GROQ_API_KEY)

def generate_recommendation(detections, count, avg_conf, severity):
    try:
        insects = [d["class"] for d in detections]

        prompt = f"""
        Detected insects: {insects}
        Count: {count}
        Average confidence: {avg_conf}
        Severity: {severity}

        IMPORTANT:
        - You MUST use the given severity: {severity}
        - DO NOT change it

        Respond ONLY in JSON:
        {{
          "severity": "{severity}",
          "treatment": "short actionable advice",
          "prevention": "short preventive steps"
        }}
        """

        response = client.chat.completions.create(
            messages=[{"role": "user", "content": prompt}],
            model="llama-3.1-8b-instant"
        )

        content = response.choices[0].message.content

        # Convert to JSON safely
        try:
            return json.loads(content)
        except:
            return {
                "severity": severity,
                "treatment": content,
                "prevention": "Follow general pest control practices"
            }

    except Exception as e:
        return {
            "severity": severity,
            "error": "LLM failed",
            "details": str(e)
        }