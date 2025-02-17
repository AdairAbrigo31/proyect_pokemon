
import 'package:dio/dio.dart';
import 'package:my_pokemon_tia/domain/entities/entities.dart';
import 'package:my_pokemon_tia/infrastructure/mappers/mappers.dart';

class PokeApi {

  final String routeBase = 'https://pokeapi.co/api/v2';

  final Dio dio = Dio();
  

  Future<List<PokemonEntity>> getPokemons () async {

    try {

      final List<PokemonEntity> pokemons = [];

      final request = await dio.get('$routeBase/pokemon?limit=50',);
      
      final results = request.data['results'] as List;

      for (var result in results) {

        final responsePokemon = await dio.get(result['url']); 

        final pokemon = PokemonMapper.fromMap(responsePokemon.data);

        pokemons.add(pokemon);

      }

      return pokemons;

    } catch (error) {

      throw ("$error");
    
    }
  }


  Future<List<PokemonEntity>> getPokemonsByNames ( List<String> names ) async {

    try {

      final List<PokemonEntity> pokemons = [];

      for (var name in names) {

        final request = await dio.get('$routeBase/pokemon/$name');

        final response = request.data;

        final pokemon = PokemonMapper.fromMap(response);

        pokemons.add(pokemon);

      }

      return pokemons;

    } catch ( error ) {

      throw ('$error');

    }
  }



  Future<PokemonEntity> getPokemonByName ( String name ) async {

    try {

      final request = await dio.get('$routeBase/pokemon/$name');

      final response = request.data;

      final pokemon = PokemonMapper.fromMap(response);

      return pokemon;

    } catch (error) {

      throw ("$error");

    }
  }



  Future<int> findPokemonEspeciesId (int id) async {

    try {

      final response = await dio.get('$routeBase/pokemon-species/$id');

      final pokemon = response.data;

      final url = pokemon['evolution_chain']['url'];

      // Eliminar cualquier slash final
      final cleanUrl = url.replaceAll(RegExp(r'/+$'), '');
      
      // Dividir la URL y obtener el último segmento
      final parts = cleanUrl.split('/');

      return int.parse(cleanUrl.split('/').last);

    } catch (error) {

      throw ("$error");

    }
  }



  String? _findNextEvolutionName(Map<String, dynamic> chain, String currentPokemonName) {

    // Caso 1: Si es el pokemon inicial
    if (chain['species']['name'] == currentPokemonName) {
      if (chain['evolves_to'].isNotEmpty) {
        return chain['evolves_to'][0]['species']['name'];
      }
    }

    // Caso 2: Si es la primera evolución
    if (chain['evolves_to'].isNotEmpty) {
      final firstEvolution = chain['evolves_to'][0];
      if (firstEvolution['species']['name'] == currentPokemonName) {
        if (firstEvolution['evolves_to'].isNotEmpty) {
          return firstEvolution['evolves_to'][0]['species']['name'];
        }
      }
    }

    return null;
  }



  Future<PokemonEntity?> getNextEvolution ( PokemonEntity pokemon, int evolutionChainId ) async {

    try {
    
    final response = await dio.get('$routeBase/evolution-chain/$evolutionChainId');
    final chain = response.data['chain'];

    // Encontrar la siguiente evolución
    String? nextEvolutionName = _findNextEvolutionName(chain, pokemon.name);
    
    // Si no hay siguiente evolución, retornar null
    if (nextEvolutionName == null) return null;

    // Obtener el pokemon de la siguiente evolución
    return await getPokemonByName(nextEvolutionName);

  } catch (error) {
    throw Exception("Error al obtener evolución: $error");
  }
  }
}