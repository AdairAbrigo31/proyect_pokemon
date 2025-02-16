
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const bycrypt = require('bcrypt');

const User = sequelize.define('User', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    username: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true
    },
    email: {
        type: DataTypes.STRING(100),
        allowNull: false,
        unique: true,
        validate: {
          isEmail: true
        }
    },
    password: {
        type: DataTypes.STRING(255),
        allowNull: false
    }
}, 

{
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    hooks: {
        beforeCreate: async (user) => {
            if (user.password) {
                const salt = await bycrypt.genSalt(10);
                user.password = await bycrypt.hash(user.password, salt);
        
            }
        }
    }
});


User.prototype.validatePassword = async function(password) {
    return await bycrypt.compare(password, this.password);
}

module.exports = User;