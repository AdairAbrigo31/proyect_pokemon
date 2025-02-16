
const express = require('express');
const cors = require('cors');
require('dotenv').config();

const authRoutes = require('./routes/auth_routes');
const pokemonRoutes = require('./routes/pokemon_routes');

const app = express();

app.use(cors());
app.use(express.json());

app.use('/api/auth', authRoutes);
app.use('/api/pokemon', pokemonRoutes);

app.use((err, req, res, next) => {
    console.error(err);
    res.status(500).json({ message: 'Error interno' });
});

const PORT = 3000; 

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});