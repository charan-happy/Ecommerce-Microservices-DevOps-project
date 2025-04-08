const express = require('express');
const app = express();
const port = 3000;

app.get('/products', (req, res) => {
    res.json({ id: 101, name: "Laptop", price: 999 });
});

app.listen(port, () => {
    console.log(`Product Service running on port ${port}`);
});
