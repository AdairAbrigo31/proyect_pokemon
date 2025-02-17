
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_pokemon_tia/domain/entities/entities.dart';
import 'package:my_pokemon_tia/presentation/providers/providers.dart';

class EvolutionPokemonController {

  

  static Future<PokemonEntity> evolutionPokemon (PokemonEntity pokemon, WidgetRef ref, String token) async {

    try {

      final pokemonNotifier = ref.read(pokemonProvider.notifier);

      final pokemonEvolutioned = await pokemonNotifier.evolucionPokemon(pokemon);

      if (pokemonEvolutioned != null) {

        //Guardar el pokemon evolucionado
        await pokemonNotifier.savePokemon(token, pokemonEvolutioned);

        //Eliminar el poken antiguo
        await pokemonNotifier.deletePokemonOfUser(token, pokemon.name);

        //Devolver el nuevo pokemon
        return pokemonEvolutioned;

      } else {
        
        return pokemon;
      }

    } catch (error) {

      throw ("$error");

    }
  }
}