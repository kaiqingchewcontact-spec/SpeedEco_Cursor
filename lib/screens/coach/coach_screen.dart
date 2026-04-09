import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../models/coach_suggestion.dart';
import '../../providers/coach_provider.dart';
import '../../widgets/eco_card.dart';

class CoachScreen extends StatelessWidget {
  const CoachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CoachProvider>(
      builder: (context, coach, _) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: SpeedEcoColors.background,
              title: const Text('AI Speed Coach'),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: SpeedEcoColors.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome_rounded,
                          color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'AI',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAIHeader()
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slideY(begin: 0.1),
                    const SizedBox(height: 20),
                    _buildCategoryFilter(coach)
                        .animate()
                        .fadeIn(delay: 100.ms, duration: 400.ms),
                    const SizedBox(height: 20),
                    ...coach.filteredSuggestions.asMap().entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildSuggestionCard(entry.value)
                            .animate(
                                delay: Duration(
                                    milliseconds: 150 + entry.key * 80))
                            .fadeIn(duration: 400.ms)
                            .slideY(begin: 0.05),
                      );
                    }),
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

  Widget _buildAIHeader() {
    return EcoCard(
      gradient: const LinearGradient(
        colors: [Color(0xFF0D2840), Color(0xFF15375E)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: SpeedEcoColors.primaryGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.psychology_rounded,
                color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your daily green speed plan',
                  style: TextStyle(
                    color: SpeedEcoColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '6 suggestions • Save ~45 mins & 3.6 kg CO₂',
                  style: TextStyle(
                    color: SpeedEcoColors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(CoachProvider coach) {
    final categories = [null, ...SuggestionCategory.values];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          final isSelected = coach.selectedCategory == cat;
          final label = cat?.label ?? 'All';
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => coach.selectCategory(cat),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? SpeedEcoColors.primary
                      : SpeedEcoColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? SpeedEcoColors.primary
                        : SpeedEcoColors.divider,
                  ),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : SpeedEcoColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSuggestionCard(CoachSuggestion suggestion) {
    return EcoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: suggestion.category.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(suggestion.icon,
                    color: suggestion.category.color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      suggestion.title,
                      style: const TextStyle(
                        color: SpeedEcoColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: suggestion.category.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        suggestion.category.label,
                        style: TextStyle(
                          color: suggestion.category.color,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            suggestion.description,
            style: const TextStyle(
              color: SpeedEcoColors.textSecondary,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: SpeedEcoColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.bolt_rounded,
                    color: SpeedEcoColors.primary, size: 16),
                const SizedBox(width: 6),
                Text(
                  suggestion.impact,
                  style: const TextStyle(
                    color: SpeedEcoColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
