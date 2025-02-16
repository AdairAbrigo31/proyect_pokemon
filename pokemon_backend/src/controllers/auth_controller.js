
const jwt = require ('jsonwebtoken');
const bycrypt = require('bcrypt');
const User = require('../models/user');

const authController = {

    register: async (req , res) => {
        try {

            const { email, password } = req.body;

            const userExists = await User.findOne({ where: { email } });

            if (userExists) {
                return res.status(400).json({message: 'El usuario ya existe'});
            }


            const user = await User.create({ email, password });

            const token = jwt.sign(
                { 
                    id: user.id ,
                }, 
                process.env.JWT_SECRET, {
                expiresIn: '1h'
            });


            res.status(201).json({
                message: 'Usuario registrado correctamente',
                token
            });


        } catch (error) {

            console.error(error);
            res.status(400).json({message: 'Error al registrar el usuario'});

        }
    },



    login: async (req, res) => { 
        try {

            const { email, password } = req.body;

            const user = await User.findOne({ where: { email } });

            if (!user) {
                return res.status(400).json({message: 'Usuario o contraseña incorrecta'});
            }

            const isValidPassword = await user.validatePassword(password);

            if (!isValidPassword) {
                return res.status(400).json({message: 'Usuario o contraseña incorrecta'});
            }

            const token = jwt.sign(
                { 
                    id: user.id ,
                }, 
                process.env.JWT_SECRET, {
                expiresIn: '1h'
            });

            res.json({
                message: 'Sesión iniciada correctamente',
                token
            });


        } catch (error) {

            console.error(error);
            res.status(400).json({message: 'Error al iniciar sesión'});
        }

    }
}

module.exports = authController;



