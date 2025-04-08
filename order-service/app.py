from flask import Flask
import requests

app = Flask(__name__)

@app.route('/orders', methods=['GET'])
def get_orders():
    user = requests.get('http://localhost:8080/users').json()
    product = requests.get('http://localhost:3000/products').json()
    return f"Order for {user['name']}: {product['name']} at ${product['price']}"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
