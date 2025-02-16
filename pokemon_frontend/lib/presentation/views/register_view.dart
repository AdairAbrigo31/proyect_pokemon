
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_pokemon_tia/configuration/configuration.dart';
import 'package:my_pokemon_tia/presentation/providers/providers.dart';
import 'package:my_pokemon_tia/presentation/widgets/widgets.dart';

class RegisterView extends ConsumerStatefulWidget {

  const RegisterView({super.key});


  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    
    return _RegisterViewState();
  }
  


}

class _RegisterViewState extends ConsumerState <RegisterView> {


  bool _obscureText = true; // Para controlar la visibilidad de la contraseña
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.all(16.0),

      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Correo electrónico',
              hintText: 'ejemplo@correo.com',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _passwordController,
            obscureText: _obscureText,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: const Icon(Icons.lock),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 24),

          PrimaryButton(

            text: "Registrarse", 
            onPressed: () {

              if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor, rellena todos los campos'),
                  ),
                );
                return;
              }

              ref.read(authProvider.notifier).register(_emailController.text, _passwordController.text);
              router.pushNamed('home');
              
            }
            
          ),

          const SizedBox(height: 16),

        ],
      ),
    );
  }
  
}