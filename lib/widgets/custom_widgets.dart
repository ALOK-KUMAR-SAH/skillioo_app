import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';

class GradientScaffold extends StatelessWidget {
  final Widget child;
  const GradientScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient, //Use const from AppColors
        ),
        child: SafeArea(child: child),
      ),
    );
  }
}

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
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color ?? AppColors.glassWhite,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: AppColors.glassBorder, width: 1.5),
          ),
          child: child,
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const PrimaryButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      //Accessibility
      button: true,
      label: '$text button',
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            gradient:
                AppColors.primaryButtonGradient, //Extracted const
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPurple.withOpacity(0.4),
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
      ),
    );
  }
}

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
    //Proper input validation
    final validDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    final isDelete = key == 'del';
    final isCheck = key == 'check';
    final isValidInput = validDigits.contains(key) || key == '.' || key == ',';

    final isAction = isCheck;
    final isDeleteKey = isDelete;
    final isSpacer = !isValidInput && !isDelete && !isCheck;

    return GestureDetector(
      onTap: (isValidInput || isDelete || isCheck)
          ? () {
              HapticFeedback.selectionClick();
              onKeyPressed(isDelete ? 'backspace' : key);
            }
          : null, // Disable invalid keys
      child: Container(
        width: 80,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isAction
              ? const Color(0xFF4C6EF5)
              : isDeleteKey
              ? Colors.red.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: isDeleteKey
            ? const Icon(
                Icons.backspace_outlined,
                size: 22,
                color: Colors.white70,
              )
            : isAction
            ? const Icon(Icons.check, color: Colors.white)
            : isSpacer
            ? SizedBox.shrink() //Hide spacer keys
            : Text(
                key,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}

class GlassTextField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final int maxLines;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  const GlassTextField({
    super.key,
    required this.hint,
    this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard, // Use AppColors
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12, width: 1.2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        cursorColor: AppColors.primaryCyan,
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
