FROM python:alpine3.18
RUN pip install flask requests prometheus-flask-exporter
COPY ./app.py /app.py
CMD ["python", "app.py"]


# docker build -t service2 .
