from flask import Flask
import logging

app = Flask(__name__)
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@app.route('/')
def index():
    logger.info('Received request for /')
    return 'Hello from private EC2', 200

@app.route('/health')
def health():
    logger.info('Health check requested')
    return 'ok', 200

if __name__ == '__main__':
    # Listen on 0.0.0.0:8080 as required
    app.run(host='0.0.0.0', port=8080)
