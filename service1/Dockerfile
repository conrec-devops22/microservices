FROM python:alpine3.18
RUN pip install flask prometheus-flask-exporter
COPY ./app.py /app.py
CMD ["python", "app.py"]


# docker build -t service1 .
