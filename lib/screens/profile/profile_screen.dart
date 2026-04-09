import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/theme.dart';
import '../../config/routes.dart';
import '../../widgets/eco_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          backgroundColor: SpeedEcoColors.background,
          title: const Text('Profile'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_rounded,
                  color: SpeedEcoColors.textSecondary),
              onPressed: () {},
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildProfileHeader()
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: 0.1),
                const SizedBox(height: 24),
                _buildSubscriptionBanner(context)
                    .animate()
                    .fadeIn(delay: 100.ms, duration: 500.ms)
                    .slideY(begin: 0.1),
                const SizedBox(height: 20),
                _buildAchievements()
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 500.ms),
                const SizedBox(height: 20),
                _buildSettingsList()
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 500.ms),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return EcoCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: SpeedEcoColors.primaryGradient,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: SpeedEcoColors.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                ),
              ],
            ),
            child: const Icon(Icons.person_rounded,
                color: Colors.white, size: 40),
          ),
          const SizedBox(height: 16),
          const Text(
            'Eco Warrior',
            style: TextStyle(
              color: SpeedEcoColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Level 12 • Joined Mar 2026',
            style: TextStyle(
              color: SpeedEcoColors.textMuted,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildProfileStat('156', 'Trees'),
              Container(width: 1, height: 30, color: SpeedEcoColors.divider),
              _buildProfileStat('23', 'Streak'),
              Container(width: 1, height: 30, color: SpeedEcoColors.divider),
              _buildProfileStat('89', 'Score'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: SpeedEcoColors.primary,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: SpeedEcoColors.textMuted,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriptionBanner(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.subscription),
      child: EcoCard(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A3A5C), Color(0xFF2A5080)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: SpeedEcoColors.accent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.workspace_premium_rounded,
                  color: SpeedEcoColors.accent, size: 26),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upgrade to Premium',
                    style: TextStyle(
                      color: SpeedEcoColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Unlimited AI coaching, advanced analytics & more',
                    style: TextStyle(
                      color: SpeedEcoColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                color: SpeedEcoColors.textMuted, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievements() {
    final badges = [
      _Badge(Icons.eco_rounded, 'First Swap', SpeedEcoColors.primary),
      _Badge(Icons.local_fire_department_rounded, '7-Day Streak', SpeedEcoColors.accent),
      _Badge(Icons.park_rounded, '10 Trees', const Color(0xFF76FF03)),
      _Badge(Icons.directions_bike_rounded, 'Green Commuter', SpeedEcoColors.secondary),
      _Badge(Icons.star_rounded, 'Top 10%', const Color(0xFFAA00FF)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Achievements',
          style: TextStyle(
            color: SpeedEcoColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: badges.asMap().entries.map((entry) {
              final badge = entry.value;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: badge.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: badge.color.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Icon(badge.icon, color: badge.color, size: 28),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      badge.label,
                      style: const TextStyle(
                        color: SpeedEcoColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                )
                    .animate(delay: Duration(milliseconds: 100 * entry.key))
                    .fadeIn(duration: 400.ms)
                    .scale(begin: const Offset(0.8, 0.8)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsList() {
    final items = [
      _SettingsItem(Icons.person_outline_rounded, 'Edit Profile'),
      _SettingsItem(Icons.notifications_none_rounded, 'Notifications'),
      _SettingsItem(Icons.palette_rounded, 'Theme & Appearance'),
      _SettingsItem(Icons.link_rounded, 'Connected Apps'),
      _SettingsItem(Icons.shield_outlined, 'Privacy & Data'),
      _SettingsItem(Icons.help_outline_rounded, 'Help & Support'),
      _SettingsItem(Icons.info_outline_rounded, 'About SpeedEco'),
    ];

    return EcoCard(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: items.map((item) {
          return ListTile(
            leading: Icon(item.icon, color: SpeedEcoColors.textSecondary, size: 22),
            title: Text(
              item.label,
              style: const TextStyle(
                color: SpeedEcoColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded,
                color: SpeedEcoColors.textMuted, size: 14),
            onTap: () {},
          );
        }).toList(),
      ),
    );
  }
}

class _Badge {
  final IconData icon;
  final String label;
  final Color color;
  const _Badge(this.icon, this.label, this.color);
}

class _SettingsItem {
  final IconData icon;
  final String label;
  const _SettingsItem(this.icon, this.label);
}
