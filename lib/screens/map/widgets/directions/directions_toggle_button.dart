// lib/screens/map/widgets/directions/directions_toggle_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/screens/map/directions/bloc/directions_bloc.dart';
import 'package:tourist_app/bloc/connectivity/connectivity_bloc.dart';

class DirectionsToggleButton extends StatelessWidget {
  const DirectionsToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, connectivityState) {
        return BlocBuilder<DirectionsBloc, DirectionsState>(
          builder: (context, directionsState) {
            final isActive = directionsState is DirectionsActive;
            final isOffline = connectivityState.isOffline;

            Widget buttonWidget = Container(
              decoration: BoxDecoration(
                color: isActive ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isOffline ? 0.1 : 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: isOffline ? null : () {
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
                          color: isActive
                              ? Colors.white
                              : (isOffline ? Colors.grey : Colors.black87),
                          size: 24,
                        ),
                        if (isOffline)
                          Positioned(
                            top: 6,
                            right: 6,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.red.shade600,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                          )
                        else if (directionsState is DirectionsActive &&
                            directionsState.waypoints.isNotEmpty)
                          Positioned(
                            top: 6,
                            right: 6,
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${directionsState.waypoints.length}',
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
            );

            return Positioned(
              bottom: 120,
              right: 16,
              child: Opacity(
                opacity: isOffline ? 0.8 : 1.0,
                child: isOffline
                    ? Tooltip(
                  message: 'Directions not available offline',
                  preferBelow: false,
                  child: buttonWidget,
                )
                    : buttonWidget,
              ),
            );
          },
        );
      },
    );
  }
}