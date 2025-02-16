
import 'package:flutter/material.dart';
import 'package:my_pokemon_tia/presentation/views/views.dart';
import 'package:my_pokemon_tia/presentation/widgets/app_bar_pokemon.dart';

class RegisterScreen extends StatelessWidget{

  const RegisterScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBarPokemon(title: "Registro"),
      
      body: RegisterView()

    );
  }

  
}