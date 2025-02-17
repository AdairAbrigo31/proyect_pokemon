
const FavoritePokemon  = require('../models/favorite_pokemon');

const favoritePokemonController = {

    addFavorite: async (req, res) => {
        try {
          const { pokemon_id, pokemon_name } = req.body;
          const user_id = req.user.id;  // Ya viene del middleware de autenticación
    
          // Validar que vengan todos los campos necesarios
          if (!pokemon_id || !pokemon_name) {
            return res.status(400).json({
              message: 'pokemon_id y pokemon_name son requeridos'
            });
          }
    
          // Verificar si ya existe este pokemon como favorito para este usuario
          const existingFavorite = await FavoritePokemon.findOne({
            where: {
              user_id,
              pokemon_id
            }
          });
    
          if (existingFavorite) {
            return res.status(400).json({
              message: 'Este pokemon ya está en tus favoritos'
            });
          }
    
          const favPokemon = await FavoritePokemon.create({
            user_id,
            pokemon_id,
            pokemon_name
          });
    
          res.status(201).json({
            message: 'Pokemon favorito añadido correctamente',
            favPokemon
          });
        } catch (error) {
          console.error('Error en addFavorite:', error);
          res.status(500).json({
            message: 'Error al añadir el pokemon favorito',
            error: error.message
          });
        }
      },



    getFavorites: async (req, res) => {
      try {
        const favorites = await FavoritePokemon.findAll({
            where: { user_id: req.user.id }
        });

        res.json( favorites );

      } catch (error) {
        console.error('Error al obtener favoritos:', error);
        res.status(500).json({
            message: 'Error al obtener pokemon favoritos'
        });
      }
    },


    removeFavorite: async (req, res) => {

        try {
            
            const { id } = req.params;
            const user_id = req.user.id;

            const deleted = await FavoritePokemon.destroy({
                where: {
                    id,
                    user_id // Asegura que el pokemon pertenezca al usuario
                }
            });

            if (!deleted) {
                return res.status(404).json({
                    message: 'Pokemon favorito no encontrado'
                });
            }

            res.json({
                message: 'Pokemon eliminado de favoritos'
            });
        } catch (error) {
            console.error('Error al eliminar favorito:', error);
            res.status(500).json({
                message: 'Error al eliminar pokemon de favoritos'
            });
        }
    }

}


module.exports = favoritePokemonController;


