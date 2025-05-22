// lib/screens/map/widgets/poi_details_tab.dart
import 'package:flutter/material.dart';
import 'package:tourist_app/core/extensions/context_extension.dart';
import 'package:tourist_app/models/poi.dart';

class POIDetailsTab extends StatelessWidget {
  final POI poi;

  const POIDetailsTab({
    Key? key,
    required this.poi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: _getCategoryColor(poi.category).withOpacity(0.2),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: Icon(
                    _getCategoryIcon(poi.category),
                    size: 80,
                    color: _getCategoryColor(poi.category),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Icon(
                            _getCategoryIcon(poi.category),
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            poi.category.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        poi.name,
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: _getCategoryColor(poi.category).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Navigate to ${poi.name}')),
                          );
                        },
                        icon: Icon(
                          Icons.directions,
                          color: _getCategoryColor(poi.category),
                        ),
                        tooltip: 'Navigate',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                if (poi.averageRating > 0)
                  _buildRatingRow(context, poi.averageRating),

                const SizedBox(height: 16),

                Text(
                  poi.description,
                  style: context.textTheme.bodyMedium,
                ),

                const SizedBox(height: 20),
                const Divider(height: 1),
                const SizedBox(height: 20),

                Text(
                  'DETAILS',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 12),

                if (poi.address != null) _buildInfoRow(
                  context,
                  Icons.location_on_outlined,
                  poi.address!,
                ),

                if (poi.priceCategory != null)
                  _buildInfoRow(
                    context,
                    Icons.attach_money,
                    _getPriceCategoryText(poi.priceCategory!),
                  ),

                _buildInfoRow(
                  context,
                  Icons.accessible_outlined,
                  poi.isAccessible ? 'Wheelchair accessible' : 'Not wheelchair accessible',
                  iconColor: poi.isAccessible ? Colors.green : Colors.red,
                ),

                if (poi.contactInfo != null && poi.contactInfo!.isNotEmpty)
                  _buildInfoRow(
                    context,
                    Icons.phone_outlined,
                    poi.contactInfo!['phone'] ?? 'N/A',
                  ),

                if (poi.contactInfo != null && poi.contactInfo!['website'] != null)
                  _buildInfoRow(
                    context,
                    Icons.language_outlined,
                    poi.contactInfo!['website']!,
                  ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context,
      IconData icon,
      String text, {
        Color? iconColor,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: iconColor ?? _getCategoryColor(poi.category),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingRow(BuildContext context, double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            size: 18,
            color: Colors.amber,
          ),
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade900,
            ),
          ),
          const SizedBox(width: 6),
          Row(
            children: List.generate(
              5,
                  (index) => Icon(
                index < rating.floor()
                    ? Icons.star
                    : (index < rating.ceil() && index > rating.floor())
                    ? Icons.star_half
                    : Icons.star_border,
                size: 14,
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getPriceCategoryText(String category) {
    switch (category.toLowerCase()) {
      case 'free':
        return 'Free';
      case 'inexpensive':
        return 'Inexpensive (₴)';
      case 'moderate':
        return 'Moderate (₴₴)';
      case 'expensive':
        return 'Expensive (₴₴₴)';
      case 'luxury':
        return 'Luxury (₴₴₴₴)';
      default:
        return category;
    }
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