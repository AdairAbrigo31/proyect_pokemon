
import 'package:flutter/material.dart';
import 'package:my_pokemon_tia/presentation/views/views.dart';
import 'package:my_pokemon_tia/presentation/widgets/widgets.dart';

class PokemonDetailScreen extends StatelessWidget {

  const PokemonDetailScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBarPokemon(title: "Detalle del pokémon"),

      body: PokemonDetailView()
      
    );
  }

}