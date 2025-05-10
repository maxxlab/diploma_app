// lib/core/constants/app_constants.dart
class AppConstants {
  // POI Categories
  static const List<String> poiCategories = [
    'historical',
    'museum',
    'park',
    'restaurant',
    'cafe',
    'hotel',
    'shopping',
    'entertainment',
    'transport',
    'religious',
    'natural',
    'viewpoint',
    'other'
  ];

  // Price Categories
  static const Map<String, String> priceCategories = {
    'free': 'Free',
    'inexpensive': 'Inexpensive',
    'moderate': 'Moderate',
    'expensive': 'Expensive',
    'luxury': 'Luxury'
  };

  // Event Categories
  static const List<String> eventCategories = [
    'festival',
    'concert',
    'exhibition',
    'sport',
    'theater',
    'conference',
    'other'
  ];

  // Map tile detail levels
  static const Map<int, String> mapDetailLevels = {
    1: 'Low',
    2: 'Medium',
    3: 'High'
  };
}