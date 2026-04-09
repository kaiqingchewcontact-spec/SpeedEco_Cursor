import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/theme.dart';
import '../../widgets/eco_card.dart';
import '../../widgets/gradient_button.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool _isAnnual = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: SpeedEcoColors.darkGradient),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(Icons.close_rounded,
                      color: SpeedEcoColors.textSecondary),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text('SpeedEco Premium'),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildPremiumHeader()
                          .animate()
                          .fadeIn(duration: 500.ms)
                          .slideY(begin: 0.1),
                      const SizedBox(height: 24),
                      _buildPricingToggle()
                          .animate()
                          .fadeIn(delay: 100.ms, duration: 400.ms),
                      const SizedBox(height: 20),
                      _buildPricingCard()
                          .animate()
                          .fadeIn(delay: 200.ms, duration: 500.ms)
                          .slideY(begin: 0.05),
                      const SizedBox(height: 24),
                      _buildFeaturesList()
                          .animate()
                          .fadeIn(delay: 300.ms, duration: 500.ms),
                      const SizedBox(height: 32),
                      GradientButton(
                        text: 'Start Free Trial',
                        icon: Icons.rocket_launch_rounded,
                        onPressed: () {},
                      ).animate().fadeIn(delay: 400.ms, duration: 500.ms),
                      const SizedBox(height: 12),
                      const Text(
                        '7-day free trial, then auto-renews. Cancel anytime.',
                        style: TextStyle(
                          color: SpeedEcoColors.textMuted,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumHeader() {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [SpeedEcoColors.accent, Color(0xFFFFC400)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: SpeedEcoColors.accent.withValues(alpha: 0.3),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const Icon(Icons.workspace_premium_rounded,
              color: Colors.white, size: 48),
        ),
        const SizedBox(height: 20),
        const Text(
          'Go Premium',
          style: TextStyle(
            color: SpeedEcoColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Unlock the full power of SpeedEco.\nFaster routines. Greater impact.',
          style: TextStyle(
            color: SpeedEcoColors.textSecondary,
            fontSize: 15,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPricingToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: SpeedEcoColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isAnnual = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !_isAnnual
                      ? SpeedEcoColors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Monthly',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: !_isAnnual
                        ? Colors.white
                        : SpeedEcoColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isAnnual = true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color:
                      _isAnnual ? SpeedEcoColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Annual',
                      style: TextStyle(
                        color: _isAnnual
                            ? Colors.white
                            : SpeedEcoColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (_isAnnual) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: SpeedEcoColors.accent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Save 18%',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCard() {
    return EcoCard(
      gradient: const LinearGradient(
        colors: [Color(0xFF132F54), Color(0xFF1A3D6C)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _isAnnual ? '\$49' : '\$4.99',
                style: const TextStyle(
                  color: SpeedEcoColors.textPrimary,
                  fontSize: 48,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  _isAnnual ? '/year' : '/month',
                  style: const TextStyle(
                    color: SpeedEcoColors.textMuted,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          if (_isAnnual)
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                'That\'s just \$4.08/month',
                style: TextStyle(
                  color: SpeedEcoColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      _Feature(Icons.auto_awesome_rounded, 'Unlimited AI Speed Coaching',
          'Personalized daily plans to save time & CO₂'),
      _Feature(Icons.analytics_rounded, 'Advanced Analytics',
          'Deep insights with Apple Health & Google Fit integration'),
      _Feature(Icons.palette_rounded, 'Custom Themes',
          'Personalize your app look with premium themes'),
      _Feature(Icons.group_rounded, 'Community Challenges',
          'Compete on leaderboards, join eco-challenges'),
      _Feature(Icons.description_rounded, 'Exportable Reports',
          'PDF/email weekly summaries for work or school'),
      _Feature(Icons.block_rounded, 'Ad-Free Experience',
          'No distractions, just pure eco-speed'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Everything in Premium',
          style: TextStyle(
            color: SpeedEcoColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        ...features.asMap().entries.map((entry) {
          final feature = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: SpeedEcoColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(feature.icon,
                      color: SpeedEcoColors.primary, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feature.title,
                        style: const TextStyle(
                          color: SpeedEcoColors.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        feature.subtitle,
                        style: const TextStyle(
                          color: SpeedEcoColors.textMuted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
                .animate(delay: Duration(milliseconds: 50 * entry.key))
                .fadeIn(duration: 300.ms)
                .slideX(begin: 0.05),
          );
        }),
      ],
    );
  }
}

class _Feature {
  final IconData icon;
  final String title;
  final String subtitle;
  const _Feature(this.icon, this.title, this.subtitle);
}
