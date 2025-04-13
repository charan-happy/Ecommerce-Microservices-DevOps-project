const express = require('express');
const app = express();
const port = 3000;

app.use(express.json());
app.use(express.static('public')); // Serve static files

let products = [{ id: 101, name: "Laptop", price: 999 }];
let idCounter = 102;

app.get('/products', (req, res) => {
    try {
        res.json(products);
    } catch (error) {
        res.status(500).json({ error: "Product Service failed" });
    }
});

app.get('/products/:id', (req, res) => {
    try {
        const product = products.find(p => p.id === parseInt(req.params.id));
        if (product) {
            res.json(product);
        } else {
            res.status(404).json({ error: "Product not found" });
        }
    } catch (error) {
        res.status(500).json({ error: "Product Service failed" });
    }
});

app.post('/products', (req, res) => {
    try {
        const { name, price } = req.body;
        if (!name || typeof price !== 'number' || price < 0) {
            return res.status(400).json({ error: "Invalid name or price" });
        }
        const product = { id: idCounter++, name, price };
        products.push(product);
        res.status(201).json(product);
    } catch (error) {
        res.status(500).json({ error: "Product Service failed" });
    }
});

app.put('/products/:id', (req, res) => {
    try {
        const { name, price } = req.body;
        if (!name || typeof price !== 'number' || price < 0) {
            return res.status(400).json({ error: "Invalid name or price" });
        }
        const index = products.findIndex(p => p.id === parseInt(req.params.id));
        if (index !== -1) {
            products[index] = { id: parseInt(req.params.id), name, price };
            res.json(products[index]);
        } else {
            res.status(404).json({ error: "Product not found" });
        }
    } catch (error) {
        res.status(500).json({ error: "Product Service failed" });
    }
});

app.delete('/products/:id', (req, res) => {
    try {
        const index = products.findIndex(p => p.id === parseInt(req.params.id));
        if (index !== -1) {
            products.splice(index, 1);
            res.status(204).send();
        } else {
            res.status(404).json({ error: "Product not found" });
        }
    } catch (error) {
        res.status(500).json({ error: "Product Service failed" });
    }
});

app.listen(port, () => {
    console.log(`Product Service running on port ${port}`);
});
