import json
import sys
import logging
from flask import Flask, request
from prometheus_flask_exporter import PrometheusMetrics


class StructuredFormatter(logging.Formatter):
    """
    Structure log entries as JSON objects and add request context if available
    """

    def format(self, record):
        log_entry = {
            "level": record.levelname,
            "message": record.getMessage(),
            "timestamp": self.formatTime(record),
        }
        if request:
            log_entry.update(
                {
                    "path": request.path,
                    "method": request.method,
                    "remote_addr": request.remote_addr,
                }
            )
        if record.exc_info:
            log_entry["exception"] = self.formatException(record.exc_info)
        return json.dumps(log_entry)


app = Flask(__name__)

# Set up our logging handler to use StructuredFormatter
handler = logging.StreamHandler(sys.stdout)
handler.setFormatter(StructuredFormatter())

# Add the handler to the Flask app's logger
app.logger.addHandler(handler)
app.logger.setLevel(logging.INFO)

# Also change the werkzeug logger, the default Flask logger, to use StructuredFormatter
logging.getLogger("werkzeug").addHandler(handler)


# Add Prometheus WSGI middleware to track metrics
metrics = PrometheusMetrics(app)

# Add service metadata for Prometheus
metrics.info("app_info", " Service 1", version="1.0.0")


# Add a metric to track requests by method
@metrics.counter(
    "requests_by_method",
    " Number of requests per method",
    labels={"method": lambda r: r.method},
)
@app.route("/")
def hello_world():
    app.logger.info("Service 1 called")
    return "Hello, World! This is the version 1"


# Important to run the app without debug mode or metrics endpoint will not be available
app.run(host="0.0.0.0", port=5001, debug=False)
