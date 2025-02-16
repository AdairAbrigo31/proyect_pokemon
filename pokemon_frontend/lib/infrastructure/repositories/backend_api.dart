

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:my_pokemon_tia/domain/entities/entities.dart';
import 'package:my_pokemon_tia/infrastructure/mappers/mappers.dart';

class BackendApi {

  final String routeBase = 'https://20d2-2800-bf0-8045-e58-399c-cf6e-ed5f-61aa.ngrok-free.app/api/auth';

  final Dio dio = Dio();


  Future<String> register ( String email, String password ) async {

    try {

      final Dio dio = Dio();

      final response = await dio.post('$routeBase/register', data: {
        'email': email,
        'password': password
      });

      return response.data['token'];

    } catch ( error ) {

      throw ("$error");

    }

  }



  Future<String> login ( String email, String password ) async {

    try {

      final response = await dio.post('$routeBase/login', data: {
        'email': email,
        'password': password
      });

      return response.data['token'];

    } catch ( error ) {

      throw ("$error");

    }

  }


  Future<FavoritePokemonEntity> savePokemon ( String token, PokemonEntity pokemon ) async {

    try {

      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final userId = decodedToken['id'];

      final response = await dio.post(

        '$routeBase/pokemon', 
        
        data: {
          'pokemon_name': pokemon.name,
          'pokemon_id': pokemon.id,
          'user_id': userId,

        }, options: Options(
          headers: {
            'Authorization': 'Bearer $token'
          }
        )
      );

      return FavoritePokemonMapper.fromMap(response.data);

    } catch ( error ) {

      throw ("$error");

    }

  }



  Future<List<FavoritePokemonEntity>> getFavorites ( String token ) async {

    try {

      final response = await dio.get(
        '$routeBase/pokemon',
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

}