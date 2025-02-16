
const User = require('./src/models/user');
const FavoritePokemon = require('./src/models/favorite_pokemon');
const sequelize = require('./src/config/database');

async function testModels() {
    try {

        await sequelize.authenticate();
        console.log('Conexión establecida correctamente.');

        // Sincronizar los modelos con la base de datos
        await sequelize.sync({ force: false });
        
        // Crear un usuario de prueba
        const testUser = await User.create({
            username: 'testuser2',
            email: 'test@example2.com',
            password: 'password123'
        });
        
        console.log('Usuario creado:', testUser.toJSON());

        // Crear un pokemon favorito para el usuario
        const favPokemon = await FavoritePokemon.create({
            user_id: testUser.id,
            pokemon_id: 25, // Pikachu
            pokemon_name: 'Pikachu'
        });

        console.log('Pokemon favorito creado:', favPokemon.toJSON());

    } catch (error) {
        console.error('Error durante la prueba:', error);
    } finally {
        // Cerrar la conexión
        await sequelize.close();
    }
}

testModels();