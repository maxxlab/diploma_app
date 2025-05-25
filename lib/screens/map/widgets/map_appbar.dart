// lib/screens/map/widgets/map_appbar.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_app/screens/map/bloc/map_bloc.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/auth/auth_state.dart';

class MapAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MapAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.7),
            Colors.transparent,
          ],
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Tourist Map',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 1),
                blurRadius: 3.0,
                color: Color.fromARGB(130, 0, 0, 0),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return _buildProfileButton(context, state);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileButton(BuildContext context, AuthState authState) {
    String? profileImageUrl;

    if (authState is Authenticated) {
      profileImageUrl = authState.user.profileImage;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.push('/profile'),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(2),
            child: profileImageUrl != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                profileImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildDefaultProfileIcon();
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _buildDefaultProfileIcon();
                },
              ),
            )
                : _buildDefaultProfileIcon(),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultProfileIcon() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Icon(
        Icons.person,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}