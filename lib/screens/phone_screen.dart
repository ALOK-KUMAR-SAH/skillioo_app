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
  void onKeyPressed(String value) {
    setState(() {
      if (value == 'backspace') {
        if (phoneNumber.isNotEmpty) phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
      } else if (value == 'check') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const OTPScreen()));
      } else {
        if (phoneNumber.length < 10) phoneNumber += value;
      }
    });
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
                  const Text("Step: 1 of 2", style: TextStyle(color: AppColors.textGrey)),
                  const SizedBox(height: 10),
                  const Text("What's your number?", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1B2E),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Text("91+  ", style: TextStyle(color: Colors.white54, fontSize: 20)),
                        Text(phoneNumber.isEmpty ? "0000000000" : phoneNumber, style: TextStyle(fontSize: 20, letterSpacing: 1.5, color: phoneNumber.isEmpty ? Colors.white12 : Colors.white)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  PrimaryButton(text: "Verify", onTap: () => onKeyPressed('check')),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          CustomKeyboard(onKeyPressed: onKeyPressed, showCheck: false),
        ],
      ),
    );
  }
}