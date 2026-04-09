import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../providers/forest_provider.dart';
import '../../widgets/eco_card.dart';

class ForestScreen extends StatelessWidget {
  const ForestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ForestProvider>(
      builder: (context, forest, _) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: SpeedEcoColors.background,
              title: const Text('Focus Forest'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.park_rounded,
                          color: SpeedEcoColors.primary, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        '${forest.session.totalTreesPlanted} trees',
                        style: const TextStyle(
                          color: SpeedEcoColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildForestVisual(forest)
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .scale(begin: const Offset(0.95, 0.95)),
                    const SizedBox(height: 24),
                    _buildTimerSection(context, forest)
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 500.ms),
                    const SizedBox(height: 24),
                    if (!forest.session.isActive)
                      _buildDurationSelector(forest)
                          .animate()
                          .fadeIn(delay: 300.ms, duration: 400.ms),
                    const SizedBox(height: 24),
                    _buildStats(forest)
                        .animate()
                        .fadeIn(delay: 400.ms, duration: 400.ms),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildForestVisual(ForestProvider forest) {
    return EcoCard(
      gradient: const LinearGradient(
        colors: [Color(0xFF071A0E), Color(0xFF0D2A18)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      height: 280,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 160,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (forest.session.isActive)
                  _buildGrowingTree(forest.progress),
                if (!forest.session.isActive)
                  _buildForestGrid(forest.session.treesGrown),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            forest.session.isActive
                ? 'Your tree is growing...'
                : '${forest.session.treesGrown} trees in your forest',
            style: const TextStyle(
              color: SpeedEcoColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrowingTree(double progress) {
    final treeSize = 40.0 + (progress * 100);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.park_rounded,
          size: treeSize.clamp(40, 140),
          color: Color.lerp(
            const Color(0xFF4CAF50),
            const Color(0xFF00E676),
            progress,
          ),
        ),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xFF2E7D32).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildForestGrid(int treeCount) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 4,
      children: List.generate(min(treeCount, 20), (index) {
        final sizes = [28.0, 32.0, 36.0, 24.0, 30.0];
        final colors = [
          const Color(0xFF4CAF50),
          const Color(0xFF66BB6A),
          const Color(0xFF81C784),
          const Color(0xFF00E676),
          const Color(0xFF2E7D32),
        ];
        return Icon(
          Icons.park_rounded,
          size: sizes[index % sizes.length],
          color: colors[index % colors.length],
        );
      }),
    );
  }

  Widget _buildTimerSection(BuildContext context, ForestProvider forest) {
    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: forest.session.isActive ? forest.progress : 0,
                  strokeWidth: 8,
                  backgroundColor: SpeedEcoColors.surfaceLight,
                  valueColor: const AlwaysStoppedAnimation(SpeedEcoColors.primary),
                  strokeCap: StrokeCap.round,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    forest.session.isActive
                        ? forest.timeRemaining
                        : '${forest.session.durationMinutes}:00',
                    style: const TextStyle(
                      color: SpeedEcoColors.textPrimary,
                      fontSize: 42,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    forest.session.isActive ? 'Stay focused!' : 'Ready to focus?',
                    style: const TextStyle(
                      color: SpeedEcoColors.textMuted,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (forest.session.isActive)
              _buildActionButton(
                'Give Up',
                Icons.close_rounded,
                SpeedEcoColors.error,
                forest.cancelSession,
              )
            else
              _buildActionButton(
                'Plant a Tree',
                Icons.nature_rounded,
                SpeedEcoColors.primary,
                forest.startSession,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
      String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationSelector(ForestProvider forest) {
    final durations = [15, 25, 45, 60];
    return EcoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Session Duration',
            style: TextStyle(
              color: SpeedEcoColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: durations.map((d) {
              final isSelected = forest.session.durationMinutes == d;
              return GestureDetector(
                onTap: () => forest.setDuration(d),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? SpeedEcoColors.primary
                        : SpeedEcoColors.surfaceLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? SpeedEcoColors.primary
                          : SpeedEcoColors.divider,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$d',
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : SpeedEcoColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'min',
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white70
                              : SpeedEcoColors.textMuted,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(ForestProvider forest) {
    return Row(
      children: [
        Expanded(
          child: EcoCard(
            child: Column(
              children: [
                const Icon(Icons.park_rounded,
                    color: SpeedEcoColors.primary, size: 28),
                const SizedBox(height: 8),
                Text(
                  '${forest.session.totalTreesPlanted}',
                  style: const TextStyle(
                    color: SpeedEcoColors.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Text(
                  'Total Trees',
                  style: TextStyle(
                    color: SpeedEcoColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: EcoCard(
            child: Column(
              children: [
                const Icon(Icons.timer_rounded,
                    color: SpeedEcoColors.secondary, size: 28),
                const SizedBox(height: 8),
                Text(
                  '${(forest.session.totalTreesPlanted * 25 / 60).toStringAsFixed(1)}h',
                  style: const TextStyle(
                    color: SpeedEcoColors.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Text(
                  'Focus Time',
                  style: TextStyle(
                    color: SpeedEcoColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: EcoCard(
            child: Column(
              children: [
                const Icon(Icons.cloud_off_rounded,
                    color: SpeedEcoColors.accent, size: 28),
                const SizedBox(height: 8),
                Text(
                  (forest.session.totalTreesPlanted * 6).toStringAsFixed(0),
                  style: const TextStyle(
                    color: SpeedEcoColors.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Text(
                  'kg CO₂',
                  style: TextStyle(
                    color: SpeedEcoColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
