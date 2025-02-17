
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_pokemon_tia/domain/entities/entities.dart';
import 'package:my_pokemon_tia/infrastructure/repositories/repositories.dart';


final pokemonProvider = StateNotifierProvider<PokemonNotifier, PokemonState>( (ref) {

    return PokemonNotifier( 
      PokeApi(), 
      BackendApi() 
    );

  }
);



class PokemonNotifier extends StateNotifier<PokemonState> {
  final PokeApi _pokeApi;
  final BackendApi _backendApi;

  PokemonNotifier(this._pokeApi, this._backendApi) : super(PokemonState());


  Future<List<PokemonEntity>> getPokemons() async {

    try {

      final pokemons = await _pokeApi.getPokemons();

      return pokemons;

    } catch (error) {

      return [];

    }
  }



  Future<FavoritePokemonEntity> savePokemon (String token, PokemonEntity pokemon) async {

    try {

      final favoritePokemon = await _backendApi.savePokemon(token, pokemon);

      return favoritePokemon;

    } catch (error) {

      throw ("$error");

    }

  }


  Future<List<PokemonEntity>> getPokemonsOfUser(String token) async {

    try {

      final pokemonsFavorite = await _backendApi.getFavorites(token);

      final pokemons = await _pokeApi.getPokemonsByNames(pokemonsFavorite.map((e) => e.pokemonName).toList());

      return pokemons;

    } catch (error) {

      return [];

    }
  }



  void updatePokemonSelected (PokemonEntity pokemonSelected) {

    state = state.copyWith(pokemonSelected: pokemonSelected);

  }
}




class PokemonState {
  final List<PokemonEntity> pokemons;
  final PokemonEntity? pokemonSelected;
  final bool isLoading;
  final String error;

  PokemonState({
    this.pokemons = const [],
    this.isLoading = false,
    this.pokemonSelected,
    this.error = '',
  });

  PokemonState copyWith({
    List<PokemonEntity>? pokemons,
    PokemonEntity? pokemonSelected,
    bool? isLoading,
    String? error,
  }) {
    return PokemonState(
      pokemons: pokemons ?? this.pokemons,
      pokemonSelected: pokemonSelected ?? this.pokemonSelected,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

}