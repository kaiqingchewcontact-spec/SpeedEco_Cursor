class ForestSession {
  final int durationMinutes;
  final int completedMinutes;
  final bool isActive;
  final int treesGrown;
  final int totalTreesPlanted;

  const ForestSession({
    this.durationMinutes = 25,
    this.completedMinutes = 0,
    this.isActive = false,
    this.treesGrown = 0,
    this.totalTreesPlanted = 0,
  });

  ForestSession copyWith({
    int? durationMinutes,
    int? completedMinutes,
    bool? isActive,
    int? treesGrown,
    int? totalTreesPlanted,
  }) {
    return ForestSession(
      durationMinutes: durationMinutes ?? this.durationMinutes,
      completedMinutes: completedMinutes ?? this.completedMinutes,
      isActive: isActive ?? this.isActive,
      treesGrown: treesGrown ?? this.treesGrown,
      totalTreesPlanted: totalTreesPlanted ?? this.totalTreesPlanted,
    );
  }

  double get progress =>
      durationMinutes > 0 ? completedMinutes / durationMinutes : 0;
}
