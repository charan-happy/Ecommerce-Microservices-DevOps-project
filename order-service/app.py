from flask import Flask, request
import requests

app = Flask(__name__)

@app.route('/orders', methods=['POST'])
def create_order():
    try:
        data = request.get_json()
        user_id = data.get('user_id')
        product_id = data.get('product_id')
        if not user_id or not product_id:
            return "Error: Missing user_id or product_id", 400

        user = requests.get(f'http://user-service:8080/users/{user_id}', timeout=2).json()
        if not user:
            return "Error: User not found", 404

        product = requests.get(f'http://product-service:3000/products/{product_id}', timeout=2).json()
        if not product:
            return "Error: Product not found", 404

        return f"Order for {user['name']}: {product['name']} at ${product['price']}", 201
    except (requests.RequestException, ValueError):
        return "Error: Service unavailable", 503

@app.route('/orders', methods=['GET'])
def get_orders():
    return "No orders available yet", 200  # Placeholder for future list

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
