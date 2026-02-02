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
  void onKeyPressed(String value) {
    setState(() {
      if (value == 'backspace') {
        if (otp.isNotEmpty) otp = otp.substring(0, otp.length - 1);
      } else if (value == 'check') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const VerificationSuccessScreen()));
      } else {
        if (otp.length < 4) otp += value;
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
                  const Text("Step: 2 of 2", style: TextStyle(color: AppColors.textGrey)),
                  const SizedBox(height: 10),
                  const Text("OTP Time!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      return GlassContainer(
                        width: 70, height: 70, borderRadius: 16,
                        child: Center(child: Text(otp.length > index ? otp[index] : "", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold))),
                      );
                    }),
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