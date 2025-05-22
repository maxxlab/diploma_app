// lib/screens/map/widgets/layer_control_panel.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/map_bloc.dart';

class LayerControlPanel extends StatelessWidget {
  const LayerControlPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        if (state is! MapReady || state.areas.isEmpty) {
          return const SizedBox.shrink();
        }

        // Get unique area types
        final areaTypes = state.areas.map((area) => area.type).toSet().toList();
        areaTypes.sort(); // Sort alphabetically for consistent display

        return Positioned(
          top: 80, // Position below the app bar
          right: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Layers",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(height: 1),
                ...areaTypes.map((type) => _buildLayerToggle(
                  context,
                  type,
                  state.visibleAreaTypes.contains(type),
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLayerToggle(BuildContext context, String type, bool isVisible) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Switch(
            value: isVisible,
            onChanged: (value) {
              context.read<MapBloc>().add(
                ToggleAreaVisibility(
                  areaType: type,
                  visible: value,
                ),
              );
            },
          ),
          Text(
            type.capitalize(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(width: 8),
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: _getColorForAreaType(type).withOpacity(0.5),
              border: Border.all(
                color: _getColorForAreaType(type),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForAreaType(String type) {
    switch (type.toLowerCase()) {
      case 'walking':
        return const Color(0xFF4CAF50); // Green
      case 'cycling':
        return const Color(0xFF2196F3); // Blue
      case 'restricted':
        return const Color(0xFFF44336); // Red
      case 'nature':
        return const Color(0xFF8BC34A); // Light Green
      case 'historical':
        return const Color(0xFFFFC107); // Amber
      default:
        return const Color(0xFF9C27B0); // Purple as default
    }
  }
}

// Extension to capitalize the first letter of a string
extension StringExtension on String {
  String capitalize() {
    return isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
  }
}