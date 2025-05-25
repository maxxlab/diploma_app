import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/map_bloc.dart';

class LayerControlPanel extends StatefulWidget {
  const LayerControlPanel({Key? key}) : super(key: key);

  @override
  State<LayerControlPanel> createState() => _LayerControlPanelState();
}

class _LayerControlPanelState extends State<LayerControlPanel>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _togglePanel() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        if (state is! MapReady) {
          return const SizedBox.shrink();
        }

        final areaTypes = state.areas.map((area) => area.type).toSet().toList();
        areaTypes.sort();

        if (areaTypes.isEmpty) {
          return const SizedBox.shrink();
        }

        return Positioned(
          top: 90,
          right: 16,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    alignment: Alignment.topRight,
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: _isExpanded ? _buildExpandedPanel(areaTypes, state) : null,
                    ),
                  );
                },
              ),
              AnimatedScale(
                scale: _isExpanded ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: _buildFloatingButton(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFloatingButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _togglePanel,
          borderRadius: BorderRadius.circular(28),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(
              Icons.layers,
              color: Colors.black87,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedPanel(List<String> areaTypes, MapReady state) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 250,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPanelHeader(),
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  children: areaTypes.map((type) => _buildLayerToggle(
                    context,
                    type,
                    state.visibleAreaTypes.contains(type),
                  )).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPanelHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0).copyWith(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.layers,
                color: Colors.blue.shade700,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                "Map Layers",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _togglePanel,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 32,
                  height: 32,
                  child: Icon(
                    Icons.close,
                    color: Colors.grey.shade600,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLayerToggle(BuildContext context, String type, bool isVisible) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isVisible ? Colors.blue.shade50 : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isVisible ? Colors.blue.shade200 : Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.read<MapBloc>().add(
              ToggleAreaVisibility(
                areaType: type,
                visible: !isVisible,
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: _getColorForAreaType(type).withOpacity(0.7),
                    border: Border.all(
                      color: _getColorForAreaType(type),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    type.capitalize(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: isVisible ? FontWeight.w600 : FontWeight.normal,
                      color: isVisible ? Colors.blue.shade800 : Colors.grey.shade700,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isVisible ? Colors.blue.shade600 : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: AnimatedScale(
                    scale: isVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 150),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getColorForAreaType(String type) {
    switch (type.toLowerCase()) {
      case 'walking':
        return const Color(0xFF4CAF50);
      case 'cycling':
        return const Color(0xFF2196F3);
      case 'restricted':
        return const Color(0xFFF44336);
      case 'nature':
        return const Color(0xFF8BC34A);
      case 'historical':
        return const Color(0xFFFFC107);
      default:
        return const Color(0xFF9C27B0);
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
  }
}