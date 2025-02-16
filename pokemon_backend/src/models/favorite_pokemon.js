
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const FavoritePokemon = sequelize.define('FavoritePokemons', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    user_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: 'Users',
            key: 'id'
        }
    },
    pokemon_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    pokemon_name: {
        type: DataTypes.STRING,
        allowNull: false
    },

}, 

{
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    indexes: [
        {
            unique: true,
            fields: ['user_id', 'pokemon_id']
        }
    ]
});


const User = require('./user');
FavoritePokemon.belongsTo(User, { foreignKey: 'user_id' });
User.hasMany(FavoritePokemon, { foreignKey: 'user_id' });

module.exports = FavoritePokemon;