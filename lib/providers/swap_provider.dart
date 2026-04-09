import 'package:flutter/material.dart';
import '../models/eco_swap.dart';

class SwapProvider extends ChangeNotifier {
  final List<EcoSwap> _swaps = const [
    EcoSwap(
      original: 'Amazon delivery (2-day)',
      alternative: 'Buy from local Eco-Shop',
      benefit: 'Support local business, zero-packaging option',
      icon: Icons.local_shipping_rounded,
      co2Reduction: 1.5,
      category: SwapCategory.shopping,
    ),
    EcoSwap(
      original: 'Grab ride to office',
      alternative: 'E-scooter + MRT combo',
      benefit: '3x less CO₂, often faster in rush hour',
      icon: Icons.electric_scooter_rounded,
      co2Reduction: 2.1,
      category: SwapCategory.transport,
    ),
    EcoSwap(
      original: 'Takeaway nasi lemak (styrofoam)',
      alternative: 'Bring your tiffin carrier',
      benefit: 'Zero waste + some shops give RM0.50 off',
      icon: Icons.lunch_dining_rounded,
      co2Reduction: 0.4,
      category: SwapCategory.food,
    ),
    EcoSwap(
      original: 'Bottled water (500ml)',
      alternative: 'Refill at filtered water station',
      benefit: 'Save RM3/day, reduce 1 plastic bottle',
      icon: Icons.water_drop_rounded,
      co2Reduction: 0.2,
      category: SwapCategory.food,
    ),
    EcoSwap(
      original: 'AC at 18°C all day',
      alternative: 'Set to 24°C + desk fan',
      benefit: 'Cut energy bill 30%, same comfort',
      icon: Icons.ac_unit_rounded,
      co2Reduction: 1.8,
      category: SwapCategory.home,
    ),
    EcoSwap(
      original: 'Paper towels for cleanup',
      alternative: 'Microfiber cloths (reusable)',
      benefit: 'Saves 2 rolls/week, better cleaning',
      icon: Icons.cleaning_services_rounded,
      co2Reduction: 0.3,
      category: SwapCategory.home,
    ),
  ];

  SwapCategory? _selectedCategory;

  List<EcoSwap> get swaps => _swaps;
  SwapCategory? get selectedCategory => _selectedCategory;

  List<EcoSwap> get filteredSwaps {
    if (_selectedCategory == null) return _swaps;
    return _swaps.where((s) => s.category == _selectedCategory).toList();
  }

  void selectCategory(SwapCategory? category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
