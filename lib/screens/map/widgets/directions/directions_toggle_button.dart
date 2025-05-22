// lib/screens/map/widgets/directions_toggle_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/screens/map/directions/bloc/directions_bloc.dart';

class DirectionsToggleButton extends StatelessWidget {
  const DirectionsToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DirectionsBloc, DirectionsState>(
      builder: (context, state) {
        final isActive = state is DirectionsActive;

        return Positioned(
          bottom: 120,
          right: 16,
          child: Container(
            decoration: BoxDecoration(
              color: isActive ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.read<DirectionsBloc>().add(ToggleDirectionsMode());
                },
                borderRadius: BorderRadius.circular(28),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.directions_walk,
                        color: isActive ? Colors.white : Colors.black87,
                        size: 24,
                      ),
                      if (state is DirectionsActive && state.waypoints.isNotEmpty)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${state.waypoints.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}