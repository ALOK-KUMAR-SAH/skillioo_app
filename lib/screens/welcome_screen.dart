import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_widgets.dart';
import 'phone_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Column(
        children: [
          const SizedBox(height: 50),
          Image.asset(AppColors.logo, width: 100, height: 100),
          const Spacer(),
          SizedBox(
            height: 320,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 250, height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [Colors.cyanAccent.withOpacity(0.2), Colors.transparent]),
                  ),
                ),
                _buildCard(scale: 0.85, offsetX: -90, imagePath: AppColors.cardLeft, opacity: 0.6),
                _buildCard(scale: 0.85, offsetX: 90, imagePath: AppColors.cardRight, opacity: 0.6),
                _buildCard(scale: 1.15, offsetX: 0, imagePath: AppColors.cardCenter, opacity: 1.0),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: Column(
              children: [
                const Text("Welcome!", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 16),
                const Text(
                  "We bring together a community of like-minded individuals and connections for top talent. Showcase your skills, build your network.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
                ),
                const SizedBox(height: 30),
                PrimaryButton(
                  text: "Let's Go",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PhoneNumberScreen())),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required double scale, required double offsetX, required String imagePath, double opacity = 1.0}) {
    return Transform.translate(
      offset: Offset(offsetX, 0),
      child: Transform.scale(
        scale: scale,
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: 170, height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20, spreadRadius: 5)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}