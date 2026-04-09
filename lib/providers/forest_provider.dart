import 'dart:async';
import 'package:flutter/material.dart';
import '../models/forest_session.dart';

class ForestProvider extends ChangeNotifier {
  ForestSession _session = const ForestSession(
    totalTreesPlanted: 23,
    treesGrown: 5,
  );

  Timer? _timer;
  int _elapsedSeconds = 0;

  ForestSession get session => _session;
  int get elapsedSeconds => _elapsedSeconds;
  int get totalSeconds => _session.durationMinutes * 60;
  double get progress => totalSeconds > 0 ? _elapsedSeconds / totalSeconds : 0;
  String get timeRemaining {
    final remaining = totalSeconds - _elapsedSeconds;
    final mins = remaining ~/ 60;
    final secs = remaining % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void setDuration(int minutes) {
    if (!_session.isActive) {
      _session = _session.copyWith(durationMinutes: minutes);
      notifyListeners();
    }
  }

  void startSession() {
    _elapsedSeconds = 0;
    _session = _session.copyWith(isActive: true);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsedSeconds++;
      if (_elapsedSeconds >= totalSeconds) {
        completeSession();
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void completeSession() {
    _timer?.cancel();
    _session = _session.copyWith(
      isActive: false,
      treesGrown: _session.treesGrown + 1,
      totalTreesPlanted: _session.totalTreesPlanted + 1,
    );
    _elapsedSeconds = 0;
    notifyListeners();
  }

  void cancelSession() {
    _timer?.cancel();
    _session = _session.copyWith(isActive: false);
    _elapsedSeconds = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
