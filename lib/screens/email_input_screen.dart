import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';
import 'address_input_screen.dart';

class EmailInputScreen extends StatelessWidget {
  const EmailInputScreen({super.key});

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
                  "Step: 2 of 3",
                  style: TextStyle(color: Colors.white54),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Enter Your Email Address",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Promise—no spam, only the good stuff.",
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),

            const SizedBox(height: 40),

            // Input
            const GlassTextField(
              hint: "For ex - abc@gmail.com",
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),

            const Spacer(),

            PrimaryButton(
              text: "Continue",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddressInputScreen(),
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
