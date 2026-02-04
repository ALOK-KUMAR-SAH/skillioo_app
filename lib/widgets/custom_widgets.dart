import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

// ==============================================================================
// 1. GRADIENT SCAFFOLD
// Wraps every screen with the app's signature dark purple/black gradient
// ==============================================================================
class GradientScaffold extends StatelessWidget {
  final Widget child;
  const GradientScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevents pixel overflow when keyboard opens
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.bgTop, Colors.black, Colors.black],
            stops: [0.0, 0.4, 1.0],
          ),
        ),
        child: SafeArea(child: child),
      ),
    );
  }
}

// ==============================================================================
// 2. GLASS CONTAINER
// Used for OTP boxes, Language pills, etc.
// ==============================================================================
class GlassContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final Widget? child;
  final Color? color;

  const GlassContainer({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 24,
    this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? AppColors.glassWhite,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.glassBorder, width: 1),
      ),
      child: child,
    );
  }
}

// ==============================================================================
// 3. PRIMARY BUTTON
// The main "Let's Go", "Continue", "Verify" button
// ==============================================================================
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const PrimaryButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)], // Purple/Indigo
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6366F1).withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// ==============================================================================
// 4. CUSTOM KEYBOARD
// The on-screen numeric keypad
// ==============================================================================
class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;
  final bool showCheck;

  const CustomKeyboard({
    super.key,
    required this.onKeyPressed,
    this.showCheck = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF151515),
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRow(['1', '2', '3', '-']),
          _buildRow(['4', '5', '6', '_']),
          _buildRow(['7', '8', '9', 'del']),
          _buildRow([',', '0', '.', 'check']),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> keys) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: keys.map((key) => _buildKey(key)).toList(),
      ),
    );
  }

  Widget _buildKey(String key) {
    bool isAction = key == 'check';
    bool isDelete = key == 'del';
    bool isSpacer = key == '-' || key == '_' || key == ',' || key == '.';

    return GestureDetector(
      onTap: () {
        if (isSpacer && key != '.') return; // Disable spacers except dot
        if (isDelete) {
          onKeyPressed('backspace');
        } else {
          onKeyPressed(key);
        }
      },
      child: Container(
        width: 80,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isAction ? const Color(0xFF4C6EF5) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: isDelete
            ? const Icon(
                Icons.backspace_outlined,
                size: 22,
                color: Colors.white70,
              )
            : isAction
            ? const Icon(Icons.check, color: Colors.white)
            : Text(
                key,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: isSpacer ? Colors.white24 : Colors.white,
                ),
              ),
      ),
    );
  }
}

// ==============================================================================
// 5. GLASS TEXT FIELD
// Input fields for Name, Email, Address screens
// ==============================================================================
class GlassTextField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final int maxLines;
  final TextInputType keyboardType;

  const GlassTextField({
    super.key,
    required this.hint,
    this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2C), // Dark background matching Figma
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12), // Subtle white border
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        cursorColor: const Color(0xFF00E5FF), // Cyan cursor to match brand
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
          icon: icon != null
              ? Icon(icon, color: Colors.white54, size: 20)
              : null,
        ),
      ),
    );
  }
}
