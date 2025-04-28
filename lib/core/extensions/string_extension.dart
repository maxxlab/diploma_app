extension StringExtensions on String {
  bool get isEmail => RegExp(
    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  ).hasMatch(this);

  String get capitalize => isNotEmpty
      ? '${this[0].toUpperCase()}${substring(1)}'
      : '';

  String get capitalizeAll => split(' ')
      .map((word) => word.capitalize)
      .join(' ');
}