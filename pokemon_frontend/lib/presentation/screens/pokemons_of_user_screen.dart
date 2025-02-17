
import 'package:flutter/material.dart';
import 'package:my_pokemon_tia/configuration/configuration.dart';
import 'package:my_pokemon_tia/presentation/views/views.dart';
import 'package:my_pokemon_tia/presentation/widgets/app_bar_pokemon.dart';

class PokemonsOfUserScreen extends StatelessWidget {

  const PokemonsOfUserScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBarPokemon(

        title: "Mis pokémons",

        actions: [

          IconButton(

            icon: const Icon(Icons.logout),
            onPressed: () {
              
              router.pushNamed('login');
            }
            
          )
              
        ],
      ),

      body: PokemonsOfUserView()
      
    );
  }

  


}