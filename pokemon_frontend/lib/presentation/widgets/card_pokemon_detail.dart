import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_pokemon_tia/domain/entities/entities.dart';
import 'package:my_pokemon_tia/presentation/providers/providers.dart';
import 'package:my_pokemon_tia/presentation/widgets/primary_button.dart';



class CardPokemonDetailed extends ConsumerWidget {
  final PokemonEntity pokemon;
  
  const CardPokemonDetailed({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Card(

      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Container(

        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header con nombre y número
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    pokemon.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '#${pokemon.id.toString().padLeft(3, '0')}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Imagen grande
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                pokemon.images!.first,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Tipos con más estilo
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pokemon.types!.map((type) => 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Chip(
                    label: Text(
                      type,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    backgroundColor: Colors.amber,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ).toList(),
            ),
            
            const SizedBox(height: 16),
            
            // Sección de habilidades
            if (pokemon.abilities != null) ...[
              const Text(
                'Habilidades',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...pokemon.abilities!.map((ability) => 
                Card(
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const Icon(Icons.auto_awesome),
                        const SizedBox(width: 8),
                        Text(
                          ability,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],

            PrimaryButton(

              text: "Agregar a favoritos", 
              
              onPressed: () async {

                try {

                  final token = ref.read(authProvider).token;
                  await ref.read(pokemonProvider.notifier).savePokemon(token!, pokemon);

                } catch ( error ) {

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $error'),
                    ),
                  );
                }

                

              }
            )
            
            // Puedes agregar más secciones aquí como stats, peso, altura, etc.
          ],
        ),
      ),
    );
  }
}