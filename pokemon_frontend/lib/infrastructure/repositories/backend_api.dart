

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:my_pokemon_tia/domain/entities/entities.dart';
import 'package:my_pokemon_tia/infrastructure/mappers/mappers.dart';

class BackendApi {

  final String routeBaseApi = 'https://ee6a-2800-bf0-8045-e58-399c-cf6e-ed5f-61aa.ngrok-free.app/api';


  final Dio dio = Dio();


  Future<String> register ( String email, String password ) async {

    try {

      final Dio dio = Dio();

      final response = await dio.post('$routeBaseApi/auth/register', data: {
        'email': email,
        'password': password
      });

      return response.data['token'];

    } catch ( error ) {

      throw ("$error");

    }

  }



  Future<String?> login ( String email, String password ) async {

    try {

      final response = await dio.post('$routeBaseApi/auth/login', data: {
        'email': email,
        'password': password
      });

      if (response.statusCode == 500) {
        return null;
      }

      if( response.statusCode == 400) {
        throw Exception('Credenciales incorrectas');
      }

      return response.data['token'];

    }  catch (error) {

    if (error is DioException && error.response?.statusCode == 400) {
      throw Exception(error.response?.data['message']);
    }
    
    throw Exception('Error en el servidor');
  }

  }


  Future<FavoritePokemonEntity> savePokemon(String token, PokemonEntity pokemon) async {
    try {
      final response = await dio.post(
        '$routeBaseApi/pokemon/favorites',
        data: {
          'pokemon_name': pokemon.name,
          'pokemon_id': pokemon.id,
          // Eliminar user_id del body porque se obtiene del token
        }, 
        options: Options(
          headers: {
            'Authorization': 'Bearer $token'
          }
        )
      );

      if (response.statusCode == 201) {  
        return FavoritePokemonMapper.fromMap(response.data['favPokemon']);

      } else if (response.statusCode == 400) {
        throw Exception('Pokemon ya guardado');

      } else {

        throw Exception(response.data['message'] ?? 'Error al guardar el pokemon');

      }
    } catch (error) {
      throw Exception("Error al guardar pokemon: $error");
    }
  }



  Future<List<FavoritePokemonEntity>> getFavorites ( String token ) async {

    try {

      final userId = JwtDecoder.decode(token)['id'];

      final response = await dio.get(
        '$routeBaseApi/pokemon/favorites',
        data: {
          'user_id': userId
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token'
          }
        )
      );

      return FavoritePokemonMapper.fromList(response.data);

    } catch ( error ) {

      throw ("$error");

    }
  
  }


  Future<void> deleteFavorite(String token, String pokemon_name) async {

    try {
      final response = await dio.delete(
        '$routeBaseApi/pokemon/favorites/$pokemon_name',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token'
          },
          validateStatus: (status) {
            return status == 204 || status == 200; // Aceptar ambos códigos
          },
        )
      );

      // Verificar respuesta
      if (response.statusCode == 404) {
        throw Exception('Pokemon favorito no encontrado');
      }
      
    } catch (error) {

      if (error is DioException) {

        if (error.response?.statusCode == 404) {
          throw Exception('Pokemon favorito no encontrado');
        }

        if (error.response?.statusCode == 500) {
          throw Exception('Error en el servidor: ${error.response?.data['message']}');
        }

      }

      throw Exception("Error al eliminar el pokemon: $error");

    }
  }


}