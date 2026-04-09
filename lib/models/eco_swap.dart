import 'package:flutter/material.dart';

class EcoSwap {
  final String original;
  final String alternative;
  final String benefit;
  final IconData icon;
  final double co2Reduction;
  final SwapCategory category;

  const EcoSwap({
    required this.original,
    required this.alternative,
    required this.benefit,
    required this.icon,
    required this.co2Reduction,
    required this.category,
  });
}

enum SwapCategory {
  food,
  shopping,
  transport,
  home,
}

extension SwapCategoryExt on SwapCategory {
  String get label {
    switch (this) {
      case SwapCategory.food:
        return 'Food';
      case SwapCategory.shopping:
        return 'Shopping';
      case SwapCategory.transport:
        return 'Transport';
      case SwapCategory.home:
        return 'Home';
    }
  }

  IconData get icon {
    switch (this) {
      case SwapCategory.food:
        return Icons.restaurant_rounded;
      case SwapCategory.shopping:
        return Icons.shopping_bag_rounded;
      case SwapCategory.transport:
        return Icons.directions_bike_rounded;
      case SwapCategory.home:
        return Icons.home_rounded;
    }
  }
}
