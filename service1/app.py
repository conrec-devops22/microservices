from flask import Flask
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
metrics = PrometheusMetrics(app)

metrics.info('app_info', ' Service 1', version = '1.0.0')

@metrics.counter(
        'requests_by_method',
        ' Number of requests per method',
        labels={'method': lambda r: r.method}
)
@app.route("/")
def main():
    return "Hello, World!"


app.run(host="0.0.0.0", port=5001, debug=False)
