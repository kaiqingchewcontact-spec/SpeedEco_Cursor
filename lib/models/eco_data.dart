class EcoData {
  final double co2SavedKg;
  final double treesEquivalent;
  final int ecoScore;
  final double waterSavedL;
  final int streakDays;
  final List<DailyEcoEntry> weeklyHistory;

  const EcoData({
    this.co2SavedKg = 0,
    this.treesEquivalent = 0,
    this.ecoScore = 0,
    this.waterSavedL = 0,
    this.streakDays = 0,
    this.weeklyHistory = const [],
  });

  EcoData copyWith({
    double? co2SavedKg,
    double? treesEquivalent,
    int? ecoScore,
    double? waterSavedL,
    int? streakDays,
    List<DailyEcoEntry>? weeklyHistory,
  }) {
    return EcoData(
      co2SavedKg: co2SavedKg ?? this.co2SavedKg,
      treesEquivalent: treesEquivalent ?? this.treesEquivalent,
      ecoScore: ecoScore ?? this.ecoScore,
      waterSavedL: waterSavedL ?? this.waterSavedL,
      streakDays: streakDays ?? this.streakDays,
      weeklyHistory: weeklyHistory ?? this.weeklyHistory,
    );
  }
}

class DailyEcoEntry {
  final String day;
  final double co2Saved;
  final int score;

  const DailyEcoEntry({
    required this.day,
    required this.co2Saved,
    required this.score,
  });
}
