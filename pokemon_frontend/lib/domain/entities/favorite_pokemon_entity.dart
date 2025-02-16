
class FavoritePokemonEntity {
  final int id;
  final int userId;
  final int pokemonId;
  final String pokemonName;

  FavoritePokemonEntity({
    required this.id,
    required this.userId,
    required this.pokemonId,
    required this.pokemonName,
  });


  FavoritePokemonEntity copyWith({
    int? id,
    int? userId,
    int? pokemonId,
    String? pokemonName,
  }) {
    return FavoritePokemonEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      pokemonId: pokemonId ?? this.pokemonId,
      pokemonName: pokemonName ?? this.pokemonName,
    );
  }
}