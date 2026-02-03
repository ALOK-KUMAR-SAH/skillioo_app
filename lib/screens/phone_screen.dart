import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_widgets.dart';
import 'otp_screen.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});
  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  String phoneNumber = "";
  bool isKeyboardVisible = false; // State to control visibility

  void onKeyPressed(String value) {
    setState(() {
      if (value == 'backspace') {
        if (phoneNumber.isNotEmpty) {
          phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
        }
      } else if (value == 'check') {
        // When Tick is clicked, HIDE keyboard, SHOW Verify button
        isKeyboardVisible = false;
      } else {
        if (phoneNumber.length < 10) phoneNumber += value;
      }
    });
  }

  void onVerifyTap() {
    // Only proceed if number is valid
    if (phoneNumber.length == 10) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OTPScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 10-digit number")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Step: 1 of 2",
                    style: TextStyle(color: AppColors.textGrey),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "What's your number?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Promise we’ll only use it to send your OTP.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 40),

                  // INPUT BOX (Clickable)
                  GestureDetector(
                    onTap: () {
                      // When box is clicked, SHOW keyboard, HIDE Verify button
                      setState(() {
                        isKeyboardVisible = true;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1B2E),
                        borderRadius: BorderRadius.circular(16),
                        border: isKeyboardVisible
                            ? Border.all(color: AppColors.primaryCyan, width: 1)
                            : null, // Highlight border when active
                      ),
                      child: Row(
                        children: [
                          const Text(
                            "91+  ",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            phoneNumber.isEmpty ? "0000000000" : phoneNumber,
                            style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 1.5,
                              color: phoneNumber.isEmpty
                                  ? Colors.white12
                                  : Colors.white,
                            ),
                          ),
                          const Spacer(),
                          // Blinking Cursor simulation if active
                          if (isKeyboardVisible)
                            Container(
                              width: 2,
                              height: 24,
                              color: AppColors.primaryCyan,
                            ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // VERIFY BUTTON (Only visible when keyboard is HIDDEN)
                  if (!isKeyboardVisible)
                    PrimaryButton(text: "Verify", onTap: onVerifyTap),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // KEYBOARD (Only visible when isKeyboardVisible is TRUE)
          if (isKeyboardVisible)
            CustomKeyboard(onKeyPressed: onKeyPressed, showCheck: true),
        ],
      ),
    );
  }
}
