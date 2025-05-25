// lib/screens/map/widgets/map_appbar.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/screens/map/bloc/map_bloc.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/auth/auth_event.dart';

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
          // _buildActionButton(
          //   icon: Icons.add_location,
          //   tooltip: 'Add Mock POIs',
          //   onPressed: () => context.read<MapBloc>().add(AddMockPOIsRequested()),
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: _buildActionButton(
              icon: Icons.logout,
              tooltip: 'Logout',
              onPressed: () => context.read<AuthBloc>().add(LogoutRequested()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon),
        tooltip: tooltip,
        onPressed: onPressed,
      ),
    );
  }
}