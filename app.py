import socket
from flask import Flask, jsonify
from urllib.parse import quote

app = Flask(__name__)

# Function to get the host machine's IP address
def get_host_ip():
    try:
        host_ip = socket.gethostbyname(socket.gethostname())
        return host_ip
    except Exception as e:
        return str(e)

@app.route('/')
def hello_world():
    return "Hello World", 200

@app.route('/error')
def bad_request():
    app.logger.error('Bad request error occurred')
    return jsonify({"error": "Bad Request"}), 400

@app.route('/host-ip')
def host_ip():
    host_ip_address = get_host_ip()
    return f"Host IP Address: {host_ip_address}", 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)