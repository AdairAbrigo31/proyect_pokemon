
import 'package:flutter/material.dart';

class SnackBarPokemon extends StatelessWidget{

  final String message;

  const SnackBarPokemon({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
  }


}