
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_pokemon_tia/presentation/screens/screens.dart';

final navigatorkey = GlobalKey<NavigatorState>();

final router = GoRouter(

  navigatorKey: navigatorkey,

  initialLocation: '/login',

  routes: [
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),

    GoRoute(
      name: 'register',
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ]
);    