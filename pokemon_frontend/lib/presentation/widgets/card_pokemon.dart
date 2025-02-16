
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_pokemon_tia/domain/entities/entities.dart';
import 'package:my_pokemon_tia/presentation/providers/pokemon_provider.dart';

class CardPokemon extends ConsumerWidget {

  final PokemonEntity pokemon;

  const CardPokemon({super.key, required this.pokemon});  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return GestureDetector(

      child: Card(

        child: Column(

          children: [
            
            ListTile(
              title: Text(pokemon.name),
              subtitle: Text(pokemon.types!.first),
              
            ),

            Image.network(pokemon.images!.first)
          ],
        )
      ),

      onTap: () {

        ref.read(pokemonProvider.notifier).updatePokemonSelected(pokemon);

        //Pushear a vista con detalles

      },
    );
    
    
  }

  
}