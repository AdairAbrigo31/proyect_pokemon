
import 'package:my_pokemon_tia/domain/entities/entities.dart';

class PokemonMapper {

  static PokemonEntity fromMap(Map<String, dynamic> map) {
    return PokemonEntity(
      id: map['id'],
      name: map['name'],
      types: (map['types'] != null) 
      ? List<String>.from(
          (map['types'] as List<dynamic>)
            .map((type) => type['type']['name'])
        )
      : null,

      images: (map['sprites'] != null) 
        ? [map['sprites']['front_default'], map['sprites']['back_default']] 
        : null,

      abilities: (map['abilities'] != null) 
        ? List<String>.from(
          (map['abilities'] as List<dynamic>)
            .map((ability) => ability['ability']['name'])
        )
        : 
        null,
    );
  }


  static List<PokemonEntity> fromList (List<dynamic> list) {

    List<PokemonEntity> pokemons = [];

    list.forEach((element) {
      pokemons.add(fromMap(element));
    });

    return pokemons;

  }
}