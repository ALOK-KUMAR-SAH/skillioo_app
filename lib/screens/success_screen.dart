import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';
import 'pin_screen.dart';

class VerificationSuccessScreen extends StatefulWidget {
  const VerificationSuccessScreen({super.key});
  @override
  State<VerificationSuccessScreen> createState() =>
      _VerificationSuccessScreenState();
}

class _VerificationSuccessScreenState extends State<VerificationSuccessScreen> {
  @override
  void initState() {
    super.initState();
    // Auto-navigate to Pin Selection after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PinSelectionScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Glowing Check Icon
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent.withOpacity(0.2),
                    Colors.purpleAccent.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Colors.blueAccent, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.4),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(Icons.check, size: 60, color: Colors.white),
            ),

            const SizedBox(height: 40),

            // Success Text
            const Text(
              "Verification Successful !",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 10),

            // Subtitle
            const Text(
              "Redirecting to next step...",
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
