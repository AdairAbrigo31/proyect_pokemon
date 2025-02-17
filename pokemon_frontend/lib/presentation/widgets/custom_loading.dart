
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  final String message;
  
  const CustomLoading({
    super.key, 
    required this.message
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        constraints: const BoxConstraints(
          maxWidth: 200, // Limitar el ancho máximo
          minHeight: 80,  // Altura mínima
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Spinner más pequeño
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Mensaje con estilo más compacto
            Flexible(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Función helper para mostrar el loading
void showLoading(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false, // No se puede cerrar tocando fuera
    builder: (context) => Center(
      child: CustomLoading(message: message),
    )
  );
}

// Función helper para ocultar el loading
void hideLoading(BuildContext context) {
  Navigator.of(context).pop();
}
