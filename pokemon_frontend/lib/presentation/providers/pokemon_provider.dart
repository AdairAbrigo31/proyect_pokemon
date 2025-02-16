
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_pokemon_tia/domain/entities/entities.dart';
import 'package:my_pokemon_tia/infrastructure/repositories/repositories.dart';


final pokemonProvider = StateNotifierProvider<PokemonNotifier, PokemonState>( (ref) {

    return PokemonNotifier( PokeApi() );

  }
);



class PokemonNotifier extends StateNotifier<PokemonState> {
  final PokeApi _PokeApi;

  PokemonNotifier(this._PokeApi) : super(PokemonState());

  Future<List<PokemonEntity>> getPokemons() async {
    
    //state = state.copyWith(isLoading: true);

    try {

      final pokemons = await _PokeApi.getPokemons();

      //state = state.copyWith(pokemons: pokemons);

      return pokemons;

    } catch (error) {

      //state = state.copyWith(error: '$error');
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