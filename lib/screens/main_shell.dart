import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../providers/navigation_provider.dart';
import 'home/home_screen.dart';
import 'coach/coach_screen.dart';
import 'swaps/swaps_screen.dart';
import 'forest/forest_screen.dart';
import 'profile/profile_screen.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  static const _screens = [
    HomeScreen(),
    CoachScreen(),
    SwapsScreen(),
    ForestScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, nav, _) {
        return Scaffold(
          body: IndexedStack(
            index: nav.currentIndex,
            children: _screens,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: SpeedEcoColors.surface,
              border: Border(
                top: BorderSide(
                  color: SpeedEcoColors.divider.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      context, nav, 0, Icons.home_rounded, 'Home'),
                    _buildNavItem(
                      context, nav, 1, Icons.psychology_rounded, 'Coach'),
                    _buildNavItem(
                      context, nav, 2, Icons.swap_horiz_rounded, 'Swaps'),
                    _buildNavItem(
                      context, nav, 3, Icons.forest_rounded, 'Forest'),
                    _buildNavItem(
                      context, nav, 4, Icons.person_rounded, 'Profile'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(BuildContext context, NavigationProvider nav, int index,
      IconData icon, String label) {
    final isSelected = nav.currentIndex == index;
    return GestureDetector(
      onTap: () => nav.setIndex(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? SpeedEcoColors.primary.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? SpeedEcoColors.primary
                  : SpeedEcoColors.textMuted,
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? SpeedEcoColors.primary
                    : SpeedEcoColors.textMuted,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
