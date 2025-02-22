
import 'package:flutter/material.dart';
import 'package:my_pokemon_tia/configuration/configuration.dart';
import 'package:my_pokemon_tia/presentation/views/home_view.dart';
import 'package:my_pokemon_tia/presentation/widgets/app_bar_pokemon.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBarPokemon(
        
        title: "Pokémons",

        actions: [
          
          IconButton(

            icon: const Icon(Icons.person_3_outlined),
            onPressed: () {

              router.pushNamed('pokemons-of-user');
            }
            
          )
              
        ],
      ),

      body: HomeView(),

    );
  }


}