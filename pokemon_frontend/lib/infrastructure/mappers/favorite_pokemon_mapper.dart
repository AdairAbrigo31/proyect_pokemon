import 'package:my_pokemon_tia/domain/entities/entities.dart';

class FavoritePokemonMapper {
  static FavoritePokemonEntity fromMap( Map<String, dynamic> map ) {
    return FavoritePokemonEntity(
      id: map['id'],
      pokemonId: map['pokemon_id'],
      userId: map['user_id'],
      pokemonName: map['pokemon_name'],
    );
  }

  static List<FavoritePokemonEntity> fromList ( List<dynamic> list ) {
    List<FavoritePokemonEntity> favorites = [];

    list.forEach((element) {
      favorites.add(fromMap(element));
    });

    return favorites;
  }
}