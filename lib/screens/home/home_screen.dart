// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_app/screens/home/map_screen.dart';
import 'package:tourist_app/screens/home/poi/bloc/poi_bloc.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../services/injector/injector.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<POIBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            context.go('/login');
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is Authenticated) {
            return const MapScreen();
          } else if (state is AuthError) {
            return Scaffold(
              body: Center(
                child: Text('Error: ${state.message}'),
              ),
            );
          } else {
            return const Scaffold(body: SizedBox()); // Default empty state
          }
        },
      ),
    );
  }
}