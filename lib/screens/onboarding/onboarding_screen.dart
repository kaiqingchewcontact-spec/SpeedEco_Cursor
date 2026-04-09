import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../config/theme.dart';
import '../../config/routes.dart';
import '../../widgets/gradient_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  final _pages = const [
    _OnboardingPage(
      icon: Icons.speed_rounded,
      iconColor: SpeedEcoColors.primary,
      title: 'Move Faster',
      subtitle: 'AI-powered suggestions to speed up your daily routines — commute, meals, errands.',
      gradient: LinearGradient(
        colors: [Color(0xFF00C853), Color(0xFF00E676)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    _OnboardingPage(
      icon: Icons.eco_rounded,
      iconColor: SpeedEcoColors.secondary,
      title: 'Stay Green',
      subtitle: 'Track your carbon footprint in real-time. Every small choice counts toward a better planet.',
      gradient: LinearGradient(
        colors: [Color(0xFF00B8D4), Color(0xFF00E5FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    _OnboardingPage(
      icon: Icons.forest_rounded,
      iconColor: Color(0xFF76FF03),
      title: 'Grow Your Forest',
      subtitle: 'Focus sessions that plant real trees. Stay productive, help the planet, earn rewards.',
      gradient: LinearGradient(
        colors: [Color(0xFF76FF03), Color(0xFF00C853)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: SpeedEcoColors.darkGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          SpeedEcoColors.primaryGradient.createShader(bounds),
                      child: const Text(
                        'SpeedEco',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (_currentPage < _pages.length - 1)
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, AppRoutes.main),
                        child: const Text(
                          'Skip',
                          style: TextStyle(color: SpeedEcoColors.textMuted),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              gradient: page.gradient,
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: page.iconColor.withValues(alpha: 0.3),
                                  blurRadius: 40,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: Icon(
                              page.icon,
                              size: 56,
                              color: Colors.white,
                            ),
                          ).animate().scale(
                                begin: const Offset(0.8, 0.8),
                                duration: 500.ms,
                                curve: Curves.easeOutBack,
                              ),
                          const SizedBox(height: 48),
                          Text(
                            page.title,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: SpeedEcoColors.textPrimary,
                              letterSpacing: -0.5,
                            ),
                            textAlign: TextAlign.center,
                          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
                          const SizedBox(height: 16),
                          Text(
                            page.subtitle,
                            style: const TextStyle(
                              fontSize: 16,
                              color: SpeedEcoColors.textSecondary,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    SmoothPageIndicator(
                      controller: _controller,
                      count: _pages.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: SpeedEcoColors.primary,
                        dotColor: SpeedEcoColors.surfaceLight,
                        dotHeight: 8,
                        dotWidth: 8,
                        expansionFactor: 3,
                      ),
                    ),
                    const SizedBox(height: 32),
                    GradientButton(
                      text: _currentPage == _pages.length - 1
                          ? 'Get Started'
                          : 'Next',
                      icon: _currentPage == _pages.length - 1
                          ? Icons.rocket_launch_rounded
                          : Icons.arrow_forward_rounded,
                      onPressed: () {
                        if (_currentPage < _pages.length - 1) {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.main);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final LinearGradient gradient;

  const _OnboardingPage({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.gradient,
  });
}
