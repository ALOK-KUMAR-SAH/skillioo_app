import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

// 1. Gradient Background Scaffold
class GradientScaffold extends StatelessWidget {
  final Widget child;
  const GradientScaffold({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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

// 2. Glass Container
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

// 3. Primary Button
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
            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
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

// 4. Custom Keyboard
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
        if (isSpacer && key != '.') return;
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
