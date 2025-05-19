// lib/core/utils/ui_helpers.dart
import 'package:flutter/material.dart';

class UIHelpers {
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static EdgeInsets get standardPadding => const EdgeInsets.all(16.0);

  static BorderRadius get standardBorderRadius => BorderRadius.circular(12.0);

  static TextStyle titleTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.bold,
      );

  static TextStyle bodyTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!;

  static Widget buildDivider() => const Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Divider(),
  );

  static IconData getCategoryIcon(String category) {
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

  static Color getCategoryColor(String category) {
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