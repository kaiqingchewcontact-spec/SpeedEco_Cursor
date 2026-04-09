import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../config/theme.dart';
import '../../providers/eco_provider.dart';
import '../../widgets/eco_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/stat_chip.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EcoProvider>(
      builder: (context, eco, _) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: SpeedEcoColors.background,
              title: Row(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        SpeedEcoColors.primaryGradient.createShader(bounds),
                    child: const Text(
                      'SpeedEco',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_none_rounded,
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
                    _buildGreeting(context)
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slideX(begin: -0.1),
                    const SizedBox(height: 20),
                    _buildEcoScoreCard(context, eco)
                        .animate()
                        .fadeIn(delay: 100.ms, duration: 500.ms)
                        .slideY(begin: 0.1),
                    const SizedBox(height: 16),
                    _buildQuickStats(eco)
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 500.ms),
                    const SizedBox(height: 24),
                    const SectionHeader(
                      title: 'Weekly Impact',
                      actionText: 'Details',
                    ),
                    _buildWeeklyChart(eco)
                        .animate()
                        .fadeIn(delay: 300.ms, duration: 500.ms)
                        .slideY(begin: 0.1),
                    const SizedBox(height: 24),
                    const SectionHeader(title: 'Today\'s Speed Wins'),
                    _buildSpeedWins()
                        .animate()
                        .fadeIn(delay: 400.ms, duration: 500.ms),
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

  Widget _buildGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Good Morning'
        : hour < 17
            ? 'Good Afternoon'
            : 'Good Evening';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: const TextStyle(
            color: SpeedEcoColors.textMuted,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'You\'re making an impact! 🌱',
          style: TextStyle(
            color: SpeedEcoColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildEcoScoreCard(BuildContext context, EcoProvider eco) {
    return EcoCard(
      gradient: const LinearGradient(
        colors: [Color(0xFF0D2137), Color(0xFF132F54)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 52,
            lineWidth: 8,
            percent: eco.data.ecoScore / 100,
            center: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${eco.data.ecoScore}',
                  style: const TextStyle(
                    color: SpeedEcoColors.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Text(
                  'ECO',
                  style: TextStyle(
                    color: SpeedEcoColors.textMuted,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            progressColor: SpeedEcoColors.primary,
            backgroundColor: SpeedEcoColors.surfaceLight,
            circularStrokeCap: CircularStrokeCap.round,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Eco-Speed Score',
                  style: TextStyle(
                    color: SpeedEcoColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${eco.data.co2SavedKg.toStringAsFixed(1)} kg CO₂ saved this week',
                  style: const TextStyle(
                    color: SpeedEcoColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.local_fire_department_rounded,
                        color: SpeedEcoColors.accent, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${eco.data.streakDays}-day streak',
                      style: const TextStyle(
                        color: SpeedEcoColors.accent,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(EcoProvider eco) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          StatChip(
            icon: Icons.cloud_off_rounded,
            value: '${eco.data.co2SavedKg.toStringAsFixed(1)} kg',
            label: 'CO₂ saved',
            color: SpeedEcoColors.primary,
          ),
          const SizedBox(width: 10),
          StatChip(
            icon: Icons.park_rounded,
            value: eco.data.treesEquivalent.toStringAsFixed(1),
            label: 'Trees equiv.',
            color: const Color(0xFF76FF03),
          ),
          const SizedBox(width: 10),
          StatChip(
            icon: Icons.water_drop_rounded,
            value: '${eco.data.waterSavedL.toInt()} L',
            label: 'Water saved',
            color: SpeedEcoColors.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart(EcoProvider eco) {
    return EcoCard(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 3,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => SpeedEcoColors.surface,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${rod.toY.toStringAsFixed(1)} kg',
                  const TextStyle(
                    color: SpeedEcoColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      days[value.toInt()],
                      style: const TextStyle(
                        color: SpeedEcoColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: eco.data.weeklyHistory.asMap().entries.map((entry) {
            return BarChartGroupData(
              x: entry.key,
              barRods: [
                BarChartRodData(
                  toY: entry.value.co2Saved,
                  gradient: SpeedEcoColors.primaryGradient,
                  width: 20,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSpeedWins() {
    final wins = [
      _SpeedWin(
        icon: Icons.directions_bike_rounded,
        title: 'Biked to work',
        subtitle: 'Saved 2.1 kg CO₂ • 25 min faster',
        color: SpeedEcoColors.secondary,
      ),
      _SpeedWin(
        icon: Icons.lunch_dining_rounded,
        title: 'Home-cooked lunch',
        subtitle: 'Saved 0.8 kg CO₂ • 15 min prep',
        color: SpeedEcoColors.primary,
      ),
      _SpeedWin(
        icon: Icons.shopping_bag_rounded,
        title: 'Local market run',
        subtitle: 'Saved 0.5 kg CO₂ • Zero packaging',
        color: SpeedEcoColors.accent,
      ),
    ];

    return Column(
      children: wins.asMap().entries.map((entry) {
        final win = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: EcoCard(
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: win.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(win.icon, color: win.color, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        win.title,
                        style: const TextStyle(
                          color: SpeedEcoColors.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        win.subtitle,
                        style: const TextStyle(
                          color: SpeedEcoColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.check_circle_rounded,
                    color: SpeedEcoColors.primary, size: 22),
              ],
            ),
          ),
        ).animate(delay: Duration(milliseconds: 100 * entry.key))
            .fadeIn(duration: 400.ms)
            .slideX(begin: 0.1);
      }).toList(),
    );
  }
}

class _SpeedWin {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _SpeedWin({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });
}
