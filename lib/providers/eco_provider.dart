import 'package:flutter/material.dart';
import '../models/eco_data.dart';

class EcoProvider extends ChangeNotifier {
  EcoData _data = const EcoData(
    co2SavedKg: 12.4,
    treesEquivalent: 2.1,
    ecoScore: 78,
    waterSavedL: 340,
    streakDays: 7,
    weeklyHistory: [
      DailyEcoEntry(day: 'Mon', co2Saved: 1.2, score: 65),
      DailyEcoEntry(day: 'Tue', co2Saved: 2.1, score: 72),
      DailyEcoEntry(day: 'Wed', co2Saved: 1.8, score: 70),
      DailyEcoEntry(day: 'Thu', co2Saved: 2.5, score: 80),
      DailyEcoEntry(day: 'Fri', co2Saved: 1.5, score: 68),
      DailyEcoEntry(day: 'Sat', co2Saved: 1.9, score: 75),
      DailyEcoEntry(day: 'Sun', co2Saved: 1.4, score: 78),
    ],
  );

  EcoData get data => _data;

  void updateEcoScore(int score) {
    _data = _data.copyWith(ecoScore: score);
    notifyListeners();
  }

  void addCo2Saved(double amount) {
    _data = _data.copyWith(
      co2SavedKg: _data.co2SavedKg + amount,
      treesEquivalent: (_data.co2SavedKg + amount) / 6.0,
    );
    notifyListeners();
  }

  void incrementStreak() {
    _data = _data.copyWith(streakDays: _data.streakDays + 1);
    notifyListeners();
  }
}
