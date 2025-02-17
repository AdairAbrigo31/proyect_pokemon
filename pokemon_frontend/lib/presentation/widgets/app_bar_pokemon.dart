


import 'package:flutter/material.dart';

class AppBarPokemon extends StatelessWidget implements PreferredSizeWidget{

  final String title;

  final List<Widget>? actions;

  const AppBarPokemon({super.key, required this.title, this.actions});


  @override
  Widget build(BuildContext context) {
    
    return AppBar(
      
      title: Text(title),

      centerTitle: true,

      actions: [
        if (actions != null) ...actions!
      ],

    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  
}