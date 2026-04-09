import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../models/eco_swap.dart';
import '../../providers/swap_provider.dart';
import '../../widgets/eco_card.dart';

class SwapsScreen extends StatelessWidget {
  const SwapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SwapProvider>(
      builder: (context, swapProv, _) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: SpeedEcoColors.background,
              title: const Text('Quick Eco-Swaps'),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader()
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slideY(begin: 0.1),
                    const SizedBox(height: 20),
                    _buildCategoryFilter(swapProv)
                        .animate()
                        .fadeIn(delay: 100.ms, duration: 400.ms),
                    const SizedBox(height: 20),
                    ...swapProv.filteredSwaps.asMap().entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildSwapCard(entry.value)
                            .animate(
                                delay: Duration(
                                    milliseconds: 150 + entry.key * 80))
                            .fadeIn(duration: 400.ms)
                            .slideX(begin: 0.05),
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

  Widget _buildHeader() {
    return EcoCard(
      gradient: const LinearGradient(
        colors: [Color(0xFF102A45), Color(0xFF183D60)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      padding: const EdgeInsets.all(20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.swap_horiz_rounded,
                  color: SpeedEcoColors.accent, size: 24),
              SizedBox(width: 10),
              Text(
                'One-Tap Alternatives',
                style: TextStyle(
                  color: SpeedEcoColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Swap everyday choices for greener alternatives. Quick, easy, and impactful.',
            style: TextStyle(
              color: SpeedEcoColors.textSecondary,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(SwapProvider swapProv) {
    final categories = [null, ...SwapCategory.values];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          final isSelected = swapProv.selectedCategory == cat;
          final label = cat?.label ?? 'All';
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => swapProv.selectCategory(cat),
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

  Widget _buildSwapCard(EcoSwap swap) {
    return EcoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: SpeedEcoColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(swap.icon,
                    color: SpeedEcoColors.error.withValues(alpha: 0.7),
                    size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      swap.original,
                      style: const TextStyle(
                        color: SpeedEcoColors.textMuted,
                        fontSize: 13,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: SpeedEcoColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.arrow_downward_rounded,
                            color: SpeedEcoColors.primary, size: 14),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            swap.alternative,
                            style: const TextStyle(
                              color: SpeedEcoColors.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            swap.benefit,
            style: const TextStyle(
              color: SpeedEcoColors.textSecondary,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: SpeedEcoColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_off_rounded,
                        color: SpeedEcoColors.primary, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '-${swap.co2Reduction} kg CO₂',
                      style: const TextStyle(
                        color: SpeedEcoColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  gradient: SpeedEcoColors.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Swap Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
