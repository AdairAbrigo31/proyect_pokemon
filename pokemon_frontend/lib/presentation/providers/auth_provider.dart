
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_pokemon_tia/infrastructure/repositories/repositories.dart';



final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  
  return AuthNotifier( BackendApi() );

});




class AuthNotifier extends StateNotifier<AuthState> {

  final BackendApi _backendApi;

  AuthNotifier(this._backendApi) : super(AuthState(isAuth: false, token: null));


  Future<void> login(String email, String password) async {

    try {

      final token = await _backendApi.login(email, password);
      state = AuthState(isAuth: true, token: token);

    } catch (error) {

      throw ("$error");
      
    }
    

  }


  Future<void> register(String email, String password) async {

    try {

      final token = await _backendApi.register(email, password);
      state = AuthState(isAuth: true, token: token);


    } catch (error) {
      throw ("$error");
    }

  }




  void logout() {
    state = AuthState(isAuth: false, token: null);
  }

}




class AuthState {
  final bool isAuth;
  final String? token;

  AuthState({required this.isAuth, this.token});
}