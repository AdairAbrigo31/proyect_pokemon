
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_pokemon_tia/presentation/providers/providers.dart';
import 'package:my_pokemon_tia/presentation/widgets/widgets.dart';

class PokemonsOfUserView extends ConsumerWidget{

  const PokemonsOfUserView({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final token = ref.watch(authProvider).token!;

    final pokemonNotifier = ref.read(pokemonProvider.notifier);

    final pokemonState = ref.watch(pokemonProvider);

    return Padding(padding : const EdgeInsets.all(16.0),

      child:  Column(

        children: [

          Text( "Estos son los pokemons que has capturado" ),

          FutureBuilder(

            key: UniqueKey(),
            
            future: pokemonNotifier.getPokemonsOfUser(token), 
            
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error: ${snapshot.error}",
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if ( snapshot.data == null || !snapshot.hasData ) {
                return Center(
                  child: Text("La petición ha fallado"),
                );
              }

              final pokemons = snapshot.data!;

              if (pokemons.isEmpty) {
                return const Center(
                  child: Text("No hay pokémons disponibles"),
                );
              }

              return Expanded (

                child: ListView.builder(

                  itemCount: pokemons.length,

                  itemBuilder: (context, index) {

                    final pokemon = pokemons[index];

                    return CardPokemonSaved(pokemon: pokemon);
                    
                  },
                )
                
              );
              
            }
          )
        ],
      )
    );
  }

  
}