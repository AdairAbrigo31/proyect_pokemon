import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_pokemon_tia/configuration/configuration.dart';
import 'package:my_pokemon_tia/domain/entities/entities.dart';
import 'package:my_pokemon_tia/presentation/providers/providers.dart';

class CardPokemonSimple extends ConsumerWidget {
  final PokemonEntity pokemon;
  
  const CardPokemonSimple({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {

        ref.read(pokemonProvider.notifier).updatePokemonSelected(pokemon);
        router.pushNamed('pokemon-detail');
        // Navegar a detalles
      },

      child: Card(

        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),

        child: Container(
          
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  pokemon.images!.first,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 12),
              
              // Nombre y Número
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      pokemon.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '#${pokemon.id.toString().padLeft(3, '0')}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Tipos
              Wrap(
                spacing: 8,
                children: pokemon.types!.map((type) => 
                  Chip(
                    label: Text(
                      type,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}