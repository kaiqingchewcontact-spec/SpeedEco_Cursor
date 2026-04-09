import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../config/theme.dart';
import '../../providers/eco_provider.dart';
import '../../widgets/eco_card.dart';
import '../../widgets/section_header.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EcoProvider>(
      builder: (context, eco, _) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: SpeedEcoColors.background,
              title: const Text('Weekly Report'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.share_rounded,
                      color: SpeedEcoColors.textSecondary),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.download_rounded,
                      color: SpeedEcoColors.textSecondary),
                  onPressed: () {},
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImpactSummary(eco)
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slideY(begin: 0.1),
                    const SizedBox(height: 24),
                    const SectionHeader(title: 'CO₂ Breakdown'),
                    _buildPieChart(eco)
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 500.ms)
                        .scale(begin: const Offset(0.9, 0.9)),
                    const SizedBox(height: 24),
                    const SectionHeader(title: 'Daily Scores'),
                    _buildScoreList(eco)
                        .animate()
                        .fadeIn(delay: 300.ms, duration: 500.ms),
                    const SizedBox(height: 24),
                    _buildShareCard()
                        .animate()
                        .fadeIn(delay: 400.ms, duration: 500.ms)
                        .slideY(begin: 0.1),
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

  Widget _buildImpactSummary(EcoProvider eco) {
    return EcoCard(
      gradient: const LinearGradient(
        colors: [Color(0xFF0A2818), Color(0xFF0D3A20)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text(
            'This Week You Saved',
            style: TextStyle(
              color: SpeedEcoColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          ShaderMask(
            shaderCallback: (bounds) =>
                SpeedEcoColors.primaryGradient.createShader(bounds),
            child: Text(
              '${eco.data.co2SavedKg.toStringAsFixed(1)} kg CO₂',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.w800,
                letterSpacing: -1,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: SpeedEcoColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Equivalent to planting ${eco.data.treesEquivalent.toStringAsFixed(1)} trees 🌳',
              style: const TextStyle(
                color: SpeedEcoColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMiniStat(
                  '${eco.data.waterSavedL.toInt()} L', 'Water', Icons.water_drop_rounded, SpeedEcoColors.secondary),
              _buildMiniStat(
                  '${eco.data.streakDays}', 'Day Streak', Icons.local_fire_department_rounded, SpeedEcoColors.accent),
              _buildMiniStat(
                  '${eco.data.ecoScore}', 'Eco Score', Icons.speed_rounded, SpeedEcoColors.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String value, String label, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: SpeedEcoColors.textMuted,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildPieChart(EcoProvider eco) {
    return EcoCard(
      height: 220,
      child: Row(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 30,
                sectionsSpace: 3,
                sections: [
                  PieChartSectionData(
                    value: 35,
                    color: SpeedEcoColors.secondary,
                    title: '35%',
                    titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                    radius: 50,
                  ),
                  PieChartSectionData(
                    value: 28,
                    color: SpeedEcoColors.primary,
                    title: '28%',
                    titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                    radius: 50,
                  ),
                  PieChartSectionData(
                    value: 22,
                    color: SpeedEcoColors.accent,
                    title: '22%',
                    titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                    radius: 50,
                  ),
                  PieChartSectionData(
                    value: 15,
                    color: const Color(0xFFAA00FF),
                    title: '15%',
                    titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                    radius: 50,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Commute', SpeedEcoColors.secondary),
              const SizedBox(height: 8),
              _buildLegendItem('Food', SpeedEcoColors.primary),
              const SizedBox(height: 8),
              _buildLegendItem('Shopping', SpeedEcoColors.accent),
              const SizedBox(height: 8),
              _buildLegendItem('Energy', const Color(0xFFAA00FF)),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: SpeedEcoColors.textSecondary,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildScoreList(EcoProvider eco) {
    return EcoCard(
      child: Column(
        children: eco.data.weeklyHistory.map((entry) {
          final percentage = entry.score / 100;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                SizedBox(
                  width: 36,
                  child: Text(
                    entry.day,
                    style: const TextStyle(
                      color: SpeedEcoColors.textMuted,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: percentage,
                      backgroundColor: SpeedEcoColors.surfaceLight,
                      valueColor: AlwaysStoppedAnimation(
                        Color.lerp(
                          SpeedEcoColors.accent,
                          SpeedEcoColors.primary,
                          percentage,
                        ),
                      ),
                      minHeight: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 30,
                  child: Text(
                    '${entry.score}',
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: SpeedEcoColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildShareCard() {
    return EcoCard(
      gradient: SpeedEcoColors.primaryGradient,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Share Your Impact',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Inspire friends to go green! Share your weekly report on social.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.ios_share_rounded,
                color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }
}
