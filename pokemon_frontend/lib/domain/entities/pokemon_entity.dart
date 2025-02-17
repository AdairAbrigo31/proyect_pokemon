

class PokemonEntity {

  final int id;
  final int? idFavorite;
  final String name;
  final List<String>? types;
  final List<String>? images;
  final List<String>? abilities;

  PokemonEntity({
    required this.id,
    this.idFavorite, 
    required this.name, 
    this.types, 
    this.images,
    this.abilities,
  });


  PokemonEntity copyWith({
    int? id,
    int? idFavorite,
    String? name,
    List<String>? types,
    List<String>? images,
    List<String>? abilities
  }) {
    return PokemonEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      types: types ?? this.types,
      images: images ?? this.images,
      abilities: abilities ?? this.abilities,
      idFavorite: idFavorite ?? this.idFavorite,
    );
  }

}