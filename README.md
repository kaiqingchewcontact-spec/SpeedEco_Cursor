# SpeedEco 🌱⚡

**Go Fast, Stay Green** — A sleek, native-feeling Flutter app for eco-conscious speed in daily life.

SpeedEco combines fast productivity, sustainable habits, and smart eco-tracking in one beautiful dark-themed package. Built with Flutter for iOS & Android.

## Features

| Feature | Description |
|---------|-------------|
| **Home Dashboard** | Real-time Eco-Speed Score, weekly CO₂ savings chart, streak tracking, and today's speed wins |
| **AI Speed Coach** | Personalized daily "green speed mode" suggestions across commute, food, shopping, energy, and routine categories |
| **Quick Eco-Swaps** | One-tap alternatives — swap everyday choices for greener options with instant CO₂ impact visibility |
| **Focus Forest** | Gamified Pomodoro-style focus sessions where completed sessions "grow" virtual trees with real-world planting partnerships |
| **Weekly Report** | Beautiful impact summary with CO₂ breakdown pie chart, daily scores, and social sharing |
| **Profile & Achievements** | Badge system, streak tracking, connected apps, and premium upgrade path |
| **Subscription** | Premium tier at $4.99/month or $49/year with 7-day free trial |

## Architecture

```
lib/
├── config/           # Theme, routes, constants
│   ├── theme.dart    # SpeedEco dark design system (colors, typography, gradients)
│   └── routes.dart   # Named route definitions
├── models/           # Data models
│   ├── eco_data.dart
│   ├── coach_suggestion.dart
│   ├── eco_swap.dart
│   └── forest_session.dart
├── providers/        # State management (Provider/ChangeNotifier)
│   ├── eco_provider.dart
│   ├── coach_provider.dart
│   ├── swap_provider.dart
│   ├── forest_provider.dart
│   └── navigation_provider.dart
├── screens/          # Screen implementations
│   ├── splash/       # Animated splash with logo
│   ├── onboarding/   # 3-page guided onboarding
│   ├── home/         # Dashboard with eco score, charts, speed wins
│   ├── coach/        # AI coaching suggestions with category filters
│   ├── swaps/        # Eco-swap cards with "Swap Now" actions
│   ├── forest/       # Focus timer with growing tree animation
│   ├── report/       # Weekly impact report with pie chart
│   ├── profile/      # User profile, achievements, settings
│   ├── subscription/ # Premium paywall with pricing toggle
│   └── main_shell.dart  # Bottom navigation container
├── widgets/          # Reusable UI components
│   ├── eco_card.dart
│   ├── stat_chip.dart
│   ├── section_header.dart
│   └── gradient_button.dart
└── main.dart         # App entry point with MultiProvider setup
```

## Tech Stack

- **Flutter 3.41+** with Dart 3.11+
- **Provider** for state management
- **fl_chart** for beautiful bar/pie charts
- **percent_indicator** for circular progress indicators
- **flutter_animate** for smooth entrance animations
- **google_fonts** (Inter) for premium typography
- **smooth_page_indicator** for onboarding dots

## Design System

- **Dark theme** with deep navy backgrounds (`#0A1628`, `#132240`)
- **Primary green** (`#00C853`) + **secondary teal** (`#00B8D4`) gradient accents
- **Inter** font family throughout
- Cards with subtle gradient backgrounds and border highlights
- Smooth spring/fade animations on every screen

## Getting Started

```bash
# Install dependencies
flutter pub get

# Run on connected device or emulator
flutter run

# Analyze code
dart analyze

# Run tests
flutter test
```

## Pricing Model

| Plan | Price |
|------|-------|
| Free | Basic tracking + limited suggestions |
| Premium Monthly | $4.99/month |
| Premium Annual | $49/year (save 18%) |

Premium unlocks: Unlimited AI coaching, advanced analytics, custom themes, community challenges, exportable reports, ad-free experience.

## Target Audience

Urban professionals aged 25-40 who want quick productivity wins combined with measurable environmental impact — without complexity or guilt-tripping.
