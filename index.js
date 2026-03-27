import express from 'express';

const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.json({
        'message': 'Hello, Kubernetes!',
        'service': 'hello-node',
        'pod': process.env.POD_NAME || 'unknown',
        'time': new Date().toISOString()
    });
});

app.get('/readyz', (req, res) => {
    res.status(200).send('OK');
});

app.get('/healthz', (req, res) => {
    res.status(200).send('OK');
});



app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});