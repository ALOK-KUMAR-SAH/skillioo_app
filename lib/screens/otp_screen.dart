import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_widgets.dart';
import 'success_screen.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String otp = "";
  bool isKeyboardVisible = false; // Controls visibility

  void onKeyPressed(String value) {
    setState(() {
      if (value == 'backspace') {
        if (otp.isNotEmpty) otp = otp.substring(0, otp.length - 1);
      } else if (value == 'check') {
        // Hide keyboard, show button
        isKeyboardVisible = false;
      } else {
        if (otp.length < 4) otp += value;
      }
    });
  }

  void onVerifyTap() {
    if (otp.length == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const VerificationSuccessScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter full 4-digit OTP")),
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
                    "Step: 2 of 2",
                    style: TextStyle(color: AppColors.textGrey),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "OTP Time!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Peep your phone and enter the code we just sent.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 40),

                  // OTP BOXES (Clickable Wrapper)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isKeyboardVisible = true;
                      });
                    },
                    child: Container(
                      color: Colors
                          .transparent, // Ensures tap area works between boxes
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(4, (index) {
                          bool isActive =
                              index == otp.length && isKeyboardVisible;
                          return GlassContainer(
                            width: 70,
                            height: 70,
                            borderRadius: 16,
                            // Highlight current box border
                            color: isActive
                                ? Colors.white.withOpacity(0.2)
                                : null,
                            child: Center(
                              child: Text(
                                otp.length > index ? otp[index] : "",
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Verify Button (Visible when keyboard is hidden)
                  if (!isKeyboardVisible)
                    PrimaryButton(text: "Verify", onTap: onVerifyTap),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // Keyboard (Visible when active)
          if (isKeyboardVisible)
            CustomKeyboard(onKeyPressed: onKeyPressed, showCheck: true),
        ],
      ),
    );
  }
}
