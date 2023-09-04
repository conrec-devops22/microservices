from flask import Flask
import requests

app = Flask(__name__)


@app.route("/")
def hello_world():
    r = requests.get("http://service1:5001")
    return f"Hello from Service 2. Service 1 says: {r.text}!"


app.run(host="0.0.0.0", port=5002, debug=True)
