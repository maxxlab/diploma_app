import 'package:flutter/material.dart';
import '../../../models/poi.dart';

class POIDetailsSheet extends StatelessWidget {
  final POI poi;

  const POIDetailsSheet({
    Key? key,
    required this.poi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            poi.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(poi.description),
          const SizedBox(height: 8),
          Text('Category: ${poi.category}'),
          if (poi.address != null) ...[
            const SizedBox(height: 4),
            Text('Address: ${poi.address}'),
          ],
          if (poi.averageRating > 0) ...[
            const SizedBox(height: 4),
            _buildRatingRow(poi.averageRating),
          ],
        ],
      ),
    );
  }

  Widget _buildRatingRow(double rating) {
    return Row(
      children: [
        const Text('Rating: '),
        ...List.generate(
          rating.round(),
              (index) => const Icon(
            Icons.star,
            size: 16,
            color: Colors.amber,
          ),
        ),
      ],
    );
  }
}