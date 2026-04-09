import 'package:flutter/material.dart';
import '../config/theme.dart';

class EcoCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final LinearGradient? gradient;
  final VoidCallback? onTap;
  final double? height;

  const EcoCard({
    super.key,
    required this.child,
    this.padding,
    this.gradient,
    this.onTap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: gradient ?? SpeedEcoColors.cardGradient,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: SpeedEcoColors.divider.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
