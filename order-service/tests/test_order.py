import requests
import unittest

class TestOrderService(unittest.TestCase):
    def test_create_order(self):
        url = "http://localhost:5000/orders"
        payload = {"user_id": 1, "product_id": 101}
        response = requests.post(url, json=payload, timeout=2)
        self.assertEqual(response.status_code, 201)
        self.assertIn("Order for Charan: Laptop", response.text)

if __name__ == '__main__':
    unittest.main()
