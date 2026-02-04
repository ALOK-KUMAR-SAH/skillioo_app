import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';
import 'email_input_screen.dart';

class NameInputScreen extends StatelessWidget {
  const NameInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  "Step: 1 of 3",
                  style: TextStyle(color: Colors.white54),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "What Should We Call You?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Drop your first and last name so we get it right.",
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),

            const SizedBox(height: 40),

            // Inputs
            const GlassTextField(hint: "First Name"),
            const SizedBox(height: 20),
            const GlassTextField(hint: "Last Name"),

            const Spacer(),

            PrimaryButton(
              text: "Continue",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmailInputScreen(),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
