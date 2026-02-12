import 'package:flutter/material.dart';

class AppColors {
  // 1. MAIN BACKGROUND & GRADIENTS
  static const Color bgTop = Color(0xFF4A00E0);
  static const Color bgBottom = Color(0xFF000000);

  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [bgTop, bgBottom, bgBottom],
    stops: [0.0, 0.4, 1.0],
  );

  // 2. BRAND & ACCENT COLORS

  static const Color primaryCyan = Color(0xFF00E5FF);
  static const Color primaryPurple = Color(0xFF6366F1);
  static const Color cardGreen = Color(0xFFC6FF00);
  static const Color textGrey = Colors.white54;

  // 3. GLASSMORPHISM UI COLORS
  static const Color glassWhite =
      Color(0x1AFFFFFF); // 10% opacity pre-calculated
  static const Color glassBorder =
      Color(0x33FFFFFF); // 20% opacity pre-calculated
  static const Color darkCard = Color(0xFF1E1E2C);

  static const Color cardSelectColor1 =
      Color(0x803D007D); // 0xFF6200EA @ 50% opacity
  static const Color cardSelectColor2 = Color(0x00000000); // Transparent

  static const LinearGradient cardSelectGradient = LinearGradient(
    colors: [cardSelectColor1, cardSelectColor2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryButtonGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient darkButtonGradient = LinearGradient(
    colors: [Color(0xFF1F2937), Color(0xFF111827)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0x331F59D9), Color(0x1AE27DFD)], // Pre-calculated opacities
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // 5. ASSET PATHS
  static const String logo = "assets/logo.png";
  static const String cardCenter = "assets/card_center.png";
  static const String cardLeft = "assets/card_left.png";
  static const String cardRight = "assets/card_right.png";
}
