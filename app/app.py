"""Minimal Flask application for CI/CD lab exercises."""

import os

from flask import Flask, jsonify

app = Flask(__name__)
APP_VERSION = os.environ.get("APP_VERSION", "1.0.0")


@app.route("/health")
def health():
    return jsonify({"status": "ok", "version": APP_VERSION})


@app.route("/api/info")
def info():
    return jsonify({
        "name": "devops-cicd-tools-lab",
        "version": APP_VERSION,
        "maintainer": "Deonarayan",
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
