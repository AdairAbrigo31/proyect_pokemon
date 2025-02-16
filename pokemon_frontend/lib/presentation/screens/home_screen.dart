
import 'package:flutter/material.dart';
import 'package:my_pokemon_tia/presentation/views/home_view.dart';
import 'package:my_pokemon_tia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar:  AppBarPokemon(title: "Pokemons"),

      body: HomeView(),

    );
  }


}