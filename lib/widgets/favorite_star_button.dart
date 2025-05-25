// lib/widgets/favorite_star_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/poi.dart';
import '../screens/profile/bloc/favorite_poi_bloc.dart';
import '../services/injector/injector.dart';

class FavoriteStarButton extends StatefulWidget {
  final POI poi;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;

  const FavoriteStarButton({
    Key? key,
    required this.poi,
    this.size = 24,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  @override
  State<FavoriteStarButton> createState() => _FavoriteStarButtonState();
}

class _FavoriteStarButtonState extends State<FavoriteStarButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isFavorite = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FavoritePOIBloc>()
        ..add(CheckIsFavorite(poiId: widget.poi.id)),
      child: BlocConsumer<FavoritePOIBloc, FavoritePOIState>(
        listener: (context, state) {
          if (state is FavoritePOIChecked) {
            setState(() {
              _isFavorite = state.isFavorite;
              _isLoading = false;
            });
          } else if (state is FavoritePOIError) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _isLoading ? null : () => _toggleFavorite(context),
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        width: widget.size + 16,
                        height: widget.size + 16,
                        child: _isLoading
                            ? Center(
                          child: SizedBox(
                            width: widget.size * 0.7,
                            height: widget.size * 0.7,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: widget.activeColor ?? Colors.red,
                            ),
                          ),
                        )
                            : Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: widget.size,
                          color: _isFavorite
                              ? (widget.activeColor ?? Colors.red)
                              : (widget.inactiveColor ?? Colors.grey.shade600),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _toggleFavorite(BuildContext context) {
    setState(() {
      _isLoading = true;
    });

    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    context.read<FavoritePOIBloc>().add(
      ToggleFavoritePOI(poi: widget.poi),
    );
  }
}