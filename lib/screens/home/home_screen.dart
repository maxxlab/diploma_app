import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../widgets/app_button.dart';
import '../../generated/l10n.dart';
import 'widgets/user_profile_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).home),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEvent.logoutRequested());
            },
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            unauthenticated: () => context.go('/login'),
          );
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return state.maybeWhen(
              authenticated: (user) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    UserProfileCard(user: user),
                    const SizedBox(height: 24),
                    AppButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          const AuthEvent.logoutRequested(),
                        );
                      },
                      label: S.of(context).logout,
                    ),
                  ],
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(
                child: Text('Error: $message'),
              ),
              orElse: () => const SizedBox(),
            );
          },
        ),
      ),
    );
  }
}