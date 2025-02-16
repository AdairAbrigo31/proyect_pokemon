
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
}