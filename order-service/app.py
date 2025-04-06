from flask import Flask

app = Flask(__name__)

@app.route('/orders', methods=['GET'])
def get_orders():
    return "Hello from Order Service!"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
