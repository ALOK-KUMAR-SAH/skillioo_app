import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';
import 'address_input_screen.dart';

class EmailInputScreen extends StatefulWidget {
  const EmailInputScreen({super.key});

  @override
  State<EmailInputScreen> createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends State<EmailInputScreen> {
  final _emailController = TextEditingController();
  String? _emailError;

  //  Email validation regex (production-grade)
  bool _isValidEmail(String email) {
    if (email.isEmpty) return false;

    // Simple but effective email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email.trim());
  }

  void _validateAndContinue() {
    final email = _emailController.text.trim();

    setState(() {
      if (email.isEmpty) {
        _emailError = 'Please enter your email address';
      } else if (!_isValidEmail(email)) {
        _emailError = 'Please enter a valid email (e.g., name@example.com)';
      } else {
        _emailError = null;
      }
    });

    // Navigate only if valid
    if (_emailError == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddressInputScreen()),
      );
    }
  }

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

            //  Email Field with Error Display
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlassTextField(
                  hint: "For ex - abc@gmail.com",
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                if (_emailError != null) ...[
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      _emailError!,
                      style: TextStyle(
                        color: Colors.red[400],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),

            const Spacer(),

            PrimaryButton(
              text: "Continue",
              onTap: _validateAndContinue,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
