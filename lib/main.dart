import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'config/theme.dart';
import 'config/routes.dart';
import 'providers/eco_provider.dart';
import 'providers/coach_provider.dart';
import 'providers/swap_provider.dart';
import 'providers/forest_provider.dart';
import 'providers/navigation_provider.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/main_shell.dart';
import 'screens/subscription/subscription_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: SpeedEcoColors.surface,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const SpeedEcoApp());
}

class SpeedEcoApp extends StatelessWidget {
  const SpeedEcoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EcoProvider()),
        ChangeNotifierProvider(create: (_) => CoachProvider()),
        ChangeNotifierProvider(create: (_) => SwapProvider()),
        ChangeNotifierProvider(create: (_) => ForestProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: MaterialApp(
        title: 'SpeedEco',
        debugShowCheckedModeBanner: false,
        theme: SpeedEcoTheme.darkTheme,
        initialRoute: AppRoutes.splash,
        routes: {
          AppRoutes.splash: (_) => const SplashScreen(),
          AppRoutes.onboarding: (_) => const OnboardingScreen(),
          AppRoutes.main: (_) => const MainShell(),
          AppRoutes.subscription: (_) => const SubscriptionScreen(),
        },
      ),
    );
  }
}
