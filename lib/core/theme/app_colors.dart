import 'package:flutter/material.dart';

/// Application color palette - Dark mode design system
class AppColors {
  AppColors._();

  // Primary colors
  static const Color primary = Color(0xFF005AA0);
  static const Color primaryLight = Color(0xFF1976D2);
  static const Color primaryDark = Color(0xFF003D71);

  // Background colors (Dark mode)
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color surfaceVariant = Color(0xFF2C2C2C);

  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textDisabled = Color(0xFF757575);

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Progress colors based on percentage
  static Color getProgressColor(double percentage) {
    if (percentage == 0) return Color(0xFF9E9E9E); // Gray for not started
    if (percentage >= 75) return success;
    if (percentage >= 50) return warning;
    return error;
  }

  // Border and divider colors
  static const Color border = Color(0xFF3A3A3A);
  static const Color divider = Color(0xFF2C2C2C);

  // Overlay colors
  static const Color overlay = Color(0x1FFFFFFF);
  static const Color scrim = Color(0x99000000);

  // Category colors - Enhanced system with gradients
  // Water (Vatten)
  static const Color categoryWater = Color(0xFF2196F3);
  static const Color categoryWaterLight = Color(0xFFE3F2FD);
  static const Color categoryWaterDark = Color(0xFF1976D2);
  
  // Food (Mat)
  static const Color categoryFood = Color(0xFFFF9800);
  static const Color categoryFoodLight = Color(0xFFFFF3E0);
  static const Color categoryFoodDark = Color(0xFFF57C00);
  
  // Heating (Värme)
  static const Color categoryHeating = Color(0xFFF44336);
  static const Color categoryHeatingLight = Color(0xFFFFEBEE);
  static const Color categoryHeatingDark = Color(0xFFE53935);
  
  // Lighting (Ljus)
  static const Color categoryLighting = Color(0xFFFFC107);
  static const Color categoryLightingLight = Color(0xFFFFF8E1);
  static const Color categoryLightingDark = Color(0xFFFFA000);
  
  // Communication/Radio
  static const Color categoryCommunication = Color(0xFF9C27B0);
  static const Color categoryCommunicationLight = Color(0xFFF3E5F5);
  static const Color categoryCommunicationDark = Color(0xFF7B1FA2);
  
  // First Aid/Medicine (Medicin)
  static const Color categoryFirstAid = Color(0xFF4CAF50);
  static const Color categoryFirstAidLight = Color(0xFFE8F5E9);
  static const Color categoryFirstAidDark = Color(0xFF388E3C);
  
  // Hygiene (Hygien)
  static const Color categoryHygiene = Color(0xFF00BCD4);
  static const Color categoryHygieneLight = Color(0xFFE0F7FA);
  static const Color categoryHygieneDark = Color(0xFF0097A7);
  
  // Cash (Kontanter)
  static const Color categoryCash = Color(0xFF8BC34A);
  static const Color categoryCashLight = Color(0xFFF1F8E9);
  static const Color categoryCashDark = Color(0xFF689F38);
  
  // Other/Default
  static const Color categoryOther = Color(0xFF9E9E9E);
  
  // Helper method to get category colors
  static Map<String, Color> getCategoryColors(String categoryId) {
    switch (categoryId) {
      case 'water':
        return {
          'primary': categoryWater,
          'light': categoryWaterLight,
          'dark': categoryWaterDark,
        };
      case 'food':
        return {
          'primary': categoryFood,
          'light': categoryFoodLight,
          'dark': categoryFoodDark,
        };
      case 'heating':
        return {
          'primary': categoryHeating,
          'light': categoryHeatingLight,
          'dark': categoryHeatingDark,
        };
      case 'lighting':
        return {
          'primary': categoryLighting,
          'light': categoryLightingLight,
          'dark': categoryLightingDark,
        };
      case 'communication':
        return {
          'primary': categoryCommunication,
          'light': categoryCommunicationLight,
          'dark': categoryCommunicationDark,
        };
      case 'first_aid':
        return {
          'primary': categoryFirstAid,
          'light': categoryFirstAidLight,
          'dark': categoryFirstAidDark,
        };
      case 'hygiene':
        return {
          'primary': categoryHygiene,
          'light': categoryHygieneLight,
          'dark': categoryHygieneDark,
        };
      case 'cash':
        return {
          'primary': categoryCash,
          'light': categoryCashLight,
          'dark': categoryCashDark,
        };
      default:
        return {
          'primary': categoryOther,
          'light': categoryOther,
          'dark': categoryOther,
        };
    }
  }

  // Semantic colors
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFFFFFFFF);
  static const Color onError = Color(0xFFFFFFFF);
}
