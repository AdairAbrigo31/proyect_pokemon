
import 'package:flutter/material.dart';
import 'package:my_pokemon_tia/presentation/views/views.dart';

class LoginScreen extends StatelessWidget{

  const LoginScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: LoginView()
      
    );
  }
}