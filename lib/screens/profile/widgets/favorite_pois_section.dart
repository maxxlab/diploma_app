// lib/screens/profile/widgets/favorite_pois_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tourist_app/core/extensions/context_extension.dart';
import 'package:tourist_app/screens/map/widgets/poi_sheet.dart';
import '../../../models/favorite_poi.dart';
import '../../../models/poi.dart';
import '../../../widgets/error_view.dart';
import '../../../widgets/laoding_view.dart';
import '../bloc/favorite_poi_bloc.dart';

class FavoritePOIsSection extends StatefulWidget {
  const FavoritePOIsSection({Key? key}) : super(key: key);

  @override
  State<FavoritePOIsSection> createState() => _FavoritePOIsSectionState();
}

class _FavoritePOIsSectionState extends State<FavoritePOIsSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: BlocBuilder<FavoritePOIBloc, FavoritePOIState>(
        builder: (context, state) {
          return Column(
            children: [
              _buildHeader(context, state),
              if (_isExpanded) _buildContent(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, FavoritePOIState state) {
    final count = state is FavoritePOILoaded ? state.favoritePOIs.length : 0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.favorite,
                  color: Colors.red.shade600,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Favorite Places',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$count saved place${count != 1 ? 's' : ''}',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              if (state is FavoritePOILoading)
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: context.colorScheme.primary,
                  ),
                )
              else
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey.shade600,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, FavoritePOIState state) {
    if (state is FavoritePOILoading) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: LoadingView(message: 'Loading favorites...'),
      );
    }

    if (state is FavoritePOIError) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: ErrorView(
          message: state.message,
          onRetry: () => context.read<FavoritePOIBloc>().add(LoadFavoritePOIs()),
        ),
      );
    }

    if (state is FavoritePOILoaded) {
      if (state.favoritePOIs.isEmpty) {
        return _buildEmptyState(context);
      }

      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: Column(
          children: [
            const Divider(height: 1),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: state.favoritePOIs.length,
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                indent: 72,
                endIndent: 20,
              ),
              itemBuilder: (context, index) {
                final favorite = state.favoritePOIs[index];
                return _buildFavoriteItem(context, favorite);
              },
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          const Divider(height: 1),
          const SizedBox(height: 24),
          Icon(
            Icons.favorite_border,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No Favorite Places Yet',
            style: context.textTheme.titleMedium?.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start exploring and save places you love by tapping the star icon',
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteItem(BuildContext context, FavoritePOI favorite) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showPOIDetails(context, favorite),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getCategoryColor(favorite.poiCategory).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getCategoryIcon(favorite.poiCategory),
                  color: _getCategoryColor(favorite.poiCategory),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      favorite.poiName,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      favorite.poiDescription,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (favorite.poiAddress != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 12,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              favorite.poiAddress!,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade500,
                                fontSize: 11,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Column(
                children: [
                  if (favorite.poiRating > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            size: 12,
                            color: Colors.amber.shade700,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            favorite.poiRating.toStringAsFixed(1),
                            style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber.shade800,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPOIDetails(BuildContext context, FavoritePOI favorite) {
    final poi = POI(
      id: favorite.poiId,
      name: favorite.poiName,
      description: favorite.poiDescription,
      category: favorite.poiCategory,
      location: GeoPoint(favorite.poiLatitude, favorite.poiLongitude),
      address: favorite.poiAddress,
      averageRating: favorite.poiRating,
    );

    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      bounce: true,
      animationCurve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
      builder: (context) => Material(
        color: Colors.transparent,
        child: POIDetailsSheet(poi: poi),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'historical':
        return Icons.account_balance;
      case 'museum':
        return Icons.museum;
      case 'park':
        return Icons.park;
      case 'restaurant':
        return Icons.restaurant;
      case 'cafe':
        return Icons.coffee;
      case 'hotel':
        return Icons.hotel;
      case 'shopping':
        return Icons.shopping_bag;
      case 'viewpoint':
        return Icons.photo_camera;
      default:
        return Icons.place;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'historical':
        return const Color(0xFF964B00);
      case 'museum':
        return const Color(0xFF9370DB);
      case 'restaurant':
        return const Color(0xFFFF4500);
      case 'cafe':
        return const Color(0xFF8B4513);
      case 'viewpoint':
        return const Color(0xFF1E90FF);
      default:
        return Colors.teal;
    }
  }
}