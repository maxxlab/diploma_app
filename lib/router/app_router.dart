import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/splash_screen.dart';
import '../bloc/auth/auth_bloc.dart';
import '../services/injector/injector.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final authBloc = getIt<AuthBloc>();
    final isAuthenticated = authBloc.state.maybeWhen(
      authenticated: (_) => true,
      orElse: () => false,
    );

    final path = state.uri.path;
    final isAuthRoute = path == '/login' || path == '/signup';

    if (!isAuthenticated && !isAuthRoute && path != '/') {
      return '/login';
    }

    if (isAuthenticated && isAuthRoute) {
      return '/home';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);