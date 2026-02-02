import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';
import 'pin_screen.dart';

class VerificationSuccessScreen extends StatefulWidget {
  const VerificationSuccessScreen({super.key});
  @override
  State<VerificationSuccessScreen> createState() => _VerificationSuccessScreenState();
}

class _VerificationSuccessScreenState extends State<VerificationSuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if(mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PinSelectionScreen()));
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
            Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent.withOpacity(0.2), border: Border.all(color: Colors.blueAccent, width: 2)), child: const Icon(Icons.check, size: 50, color: Colors.blueAccent)),
            const SizedBox(height: 30),
            const Text("Verification Successful!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}