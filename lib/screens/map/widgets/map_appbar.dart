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
    return AppBar(
      title: const Text('Tourist Map'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add_location),
          onPressed: () {
            context.read<MapBloc>().add(AddMockPOIsRequested());
          },
          tooltip: 'Add Mock POIs',
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            context.read<AuthBloc>().add(LogoutRequested());
          },
        ),
      ],
    );
  }
}