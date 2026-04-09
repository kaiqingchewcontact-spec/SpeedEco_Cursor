import 'package:flutter/material.dart';
import '../models/coach_suggestion.dart';

class CoachProvider extends ChangeNotifier {
  final List<CoachSuggestion> _suggestions = const [
    CoachSuggestion(
      title: 'Batch your errands today',
      description:
          'You have 3 stops within 2km. Combine them into one trip and save 20 minutes + fuel.',
      impact: 'Save 1.2 kg CO₂ & 20 mins',
      icon: Icons.route_rounded,
      category: SuggestionCategory.commute,
      timeSavedMins: 20,
      co2SavedKg: 1.2,
    ),
    CoachSuggestion(
      title: '15-min green meal prep',
      description:
          'Quick stir-fry with local veggies. Lower carbon footprint than ordering delivery.',
      impact: 'Save 0.8 kg CO₂ & RM12',
      icon: Icons.eco_rounded,
      category: SuggestionCategory.food,
      timeSavedMins: 15,
      co2SavedKg: 0.8,
    ),
    CoachSuggestion(
      title: 'Walk to the coffee shop',
      description:
          'The cafe is only 600m away. Walk instead of driving — bonus: 800 steps!',
      impact: 'Save 0.3 kg CO₂ + exercise',
      icon: Icons.directions_walk_rounded,
      category: SuggestionCategory.commute,
      timeSavedMins: 0,
      co2SavedKg: 0.3,
    ),
    CoachSuggestion(
      title: 'Switch to LED task light',
      description:
          'Your desk lamp uses 60W. An LED replacement uses 9W for the same brightness.',
      impact: 'Save 15 kWh/month',
      icon: Icons.lightbulb_rounded,
      category: SuggestionCategory.energy,
      timeSavedMins: 5,
      co2SavedKg: 0.5,
    ),
    CoachSuggestion(
      title: 'Buy local at Pasar Seni',
      description:
          'Skip the online order. The weekend market has fresh produce with zero packaging.',
      impact: 'Save 0.6 kg CO₂ + packaging',
      icon: Icons.storefront_rounded,
      category: SuggestionCategory.shopping,
      timeSavedMins: 10,
      co2SavedKg: 0.6,
    ),
    CoachSuggestion(
      title: 'Morning routine speed hack',
      description:
          'Prep your bag tonight. Save 12 minutes tomorrow and avoid the rush-hour spike.',
      impact: 'Save 12 mins + less stress',
      icon: Icons.speed_rounded,
      category: SuggestionCategory.routine,
      timeSavedMins: 12,
      co2SavedKg: 0.2,
    ),
  ];

  List<CoachSuggestion> get suggestions => _suggestions;

  SuggestionCategory? _selectedCategory;
  SuggestionCategory? get selectedCategory => _selectedCategory;

  List<CoachSuggestion> get filteredSuggestions {
    if (_selectedCategory == null) return _suggestions;
    return _suggestions.where((s) => s.category == _selectedCategory).toList();
  }

  void selectCategory(SuggestionCategory? category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
