# Microservices Lab 3: Add Prometheus for metrics collection

Prometheus: An open-source monitoring system with a dimensional data model, flexible query language, efficient time series database and modern alerting approach.

https://en.wikipedia.org/wiki/Prometheus_(software)

## What is metrics?

Metrics is anything you can measure. Anything, really.

## What did we do?

* We updated docker-compose.yaml with the following section:

```yaml
  prometheus:
    image: prom/prometheus:latest
    ports:
      - "9090:9090"
    networks:
      - my_network
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
```

* We created as simple prometheus.yml:

```yaml
global:
  scrape_interval: 5s
scrape_configs:
  - job_name: 'service1'
    static_configs:
      - targets: ['service1:5001']
  - job_name: 'service2'
    static_configs:
      - targets: ['service2:5002']
````

* We added `prometheus-flask-exporter` as Python package to our `Dockerfile`s.

* We added a `/metrics` endpoint to our `app.py`

```py
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
metrics = PrometheusMetrics(app, path="/metrics")
```

* We added some metrics related to our HTTP endpoint for counting number of requests.

```py
@metrics.counter(
    "invocation_by_method",
    "Number of invocations by HTTP method",
)
@app.route("/")
def hello_world():
    return "Hello, World!"
```

* We learned that <span style="color:red">**running in Debug Mode could really take extensive time to debug**</span> as it completely breaks Flask routes.

```py
app.run(host="0.0.0.0", port=5001, debug=False)  # Very important to disable debug mode
```

* We made sure we reset everything in Docker Compose, terminating any containers and even removing all images.

```sh
$ docker compose down --rmi all
```

* We started Docker Compose asking it to build our service for us.

```sh
$ docker compose up --build
```

* We visited our `/metrics` endpoint

http://127.0.0.1:5002/metrics

* We visited Prometheus and looked at the metrics collected

http://127.0.0.1:9090

* We entered a PromQL query:

`flask_http_request_duration_seconds_count` which is an automatically generated metric.

`invocation_by_method_created` is the one we created in `app.py`

Try them both out!

*Hint: watch out for date and time ranges!*