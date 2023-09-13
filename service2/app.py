from flask import Flask
from prometheus_flask_exporter import PrometheusMetrics
import requests
import logging
import logging.handlers

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

logger.info("Service 2 started")

app = Flask(__name__)
metrics = PrometheusMetrics(app)

metrics.info("app_info", " Service 2", version="1.0.0")


@app.route("/")
def main():
    logger.info("Service 2 called")
    r = requests.get("http://service1-service:5001")
    return f"Hello from Service 2. Service 1 says: {r.text}!"


app.run(host="0.0.0.0", port=5002, debug=False)
