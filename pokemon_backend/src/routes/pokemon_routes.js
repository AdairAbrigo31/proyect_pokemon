
const express = require('express');
const router = express.Router();
const pokemonController = require('../controllers/pokemon_controller');
const authMiddleware = require('../middleware/auth');

router.use(authMiddleware);

router.post('/favorites', pokemonController.addFavorite);
router.get('/favorites', pokemonController.getFavorites);
router.delete('/favorites/:pokemon_name', pokemonController.removeFavorite);

module.exports = router;