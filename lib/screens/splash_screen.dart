import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_widgets.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      if(mounted) setState(() => opacity = 1.0);
    });

    Future.delayed(const Duration(seconds: 3), () {
      if(mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const WelcomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 1),
          opacity: opacity,
          child: Image.asset(AppColors.logo, width: 200, height: 200),
        ),
      ),
    );
  }
}