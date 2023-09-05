from flask import Flask, request
import requests
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
metrics = PrometheusMetrics(app)

metrics.info("app_info", "service2", version="1.0.0")


@metrics.counter(
    "invocation_by_method",
    "Number of invocations by HTTP method",
)
@app.route("/")
def hello_world():
    r = requests.get("http://service1:5001")
    return f"Hello from Service 2. Service 1 says: {r.text}!"


app.run(host="0.0.0.0", port=5002, debug=False)  # Very important to disable debug mode
