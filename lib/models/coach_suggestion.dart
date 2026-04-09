import 'package:flutter/material.dart';

class CoachSuggestion {
  final String title;
  final String description;
  final String impact;
  final IconData icon;
  final SuggestionCategory category;
  final int timeSavedMins;
  final double co2SavedKg;

  const CoachSuggestion({
    required this.title,
    required this.description,
    required this.impact,
    required this.icon,
    required this.category,
    this.timeSavedMins = 0,
    this.co2SavedKg = 0,
  });
}

enum SuggestionCategory {
  commute,
  food,
  shopping,
  energy,
  routine,
}

extension SuggestionCategoryExt on SuggestionCategory {
  String get label {
    switch (this) {
      case SuggestionCategory.commute:
        return 'Commute';
      case SuggestionCategory.food:
        return 'Food';
      case SuggestionCategory.shopping:
        return 'Shopping';
      case SuggestionCategory.energy:
        return 'Energy';
      case SuggestionCategory.routine:
        return 'Routine';
    }
  }

  Color get color {
    switch (this) {
      case SuggestionCategory.commute:
        return const Color(0xFF00B8D4);
      case SuggestionCategory.food:
        return const Color(0xFF00C853);
      case SuggestionCategory.shopping:
        return const Color(0xFFFFD600);
      case SuggestionCategory.energy:
        return const Color(0xFFFF6D00);
      case SuggestionCategory.routine:
        return const Color(0xFFAA00FF);
    }
  }
}
