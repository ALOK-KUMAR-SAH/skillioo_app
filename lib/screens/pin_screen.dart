import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_widgets.dart';
import 'language_screen.dart';

class PinSelectionScreen extends StatefulWidget {
  const PinSelectionScreen({super.key});
  @override
  State<PinSelectionScreen> createState() => _PinSelectionScreenState();
}

class _PinSelectionScreenState extends State<PinSelectionScreen> {
  bool isBiometric = false;
  String pin = "";

  void onKeyPressed(String value) {
    if(isBiometric) return;
    setState(() {
      if (value == 'backspace') {
        if (pin.isNotEmpty) pin = pin.substring(0, pin.length - 1);
      } else if (value == 'check') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LanguageSelectionScreen()));
      } else {
        if (pin.length < 4) pin += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Image.asset(AppColors.logo, width: 80, height: 80),

                    const SizedBox(height: 20),
                    const Text("Welcome To Talent Hub", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    const Text("Choose your preferred authentication method", style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
                    const SizedBox(height: 25),

                    // Toggle Switch
                    Container(
                      height: 55, padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(30)),
                      child: Stack(
                        children: [
                          AnimatedAlign(
                            duration: const Duration(milliseconds: 250),
                            alignment: isBiometric ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                                width: (MediaQuery.of(context).size.width - 56) / 2,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25))
                            ),
                          ),
                          Row(children: [
                            Expanded(child: GestureDetector(
                                onTap: () => setState(() => isBiometric = false),
                                child: Center(child: Text("Pin", style: TextStyle(fontWeight: FontWeight.bold, color: !isBiometric ? Colors.black : Colors.white)))
                            )),
                            Expanded(child: GestureDetector(
                                onTap: () => setState(() => isBiometric = true),
                                child: Center(child: Text("Biometric", style: TextStyle(fontWeight: FontWeight.bold, color: isBiometric ? Colors.black : Colors.white)))
                            )),
                          ])
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    if (!isBiometric) ...[
                      const Text("Set Pin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            width: 55, height: 55,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: pin.length > index ? Colors.white : Colors.transparent, width: 1.5)
                            ),
                            child: Center(
                                child: pin.length > index
                                    ? Container(width: 12, height: 12, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle))
                                    : null
                            ),
                          ))
                      ),
                    ] else ...[
                      const Text("Biometric Authentication", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 20),
                      const Icon(Icons.fingerprint, size: 80, color: Colors.blueAccent),
                    ],

                    const SizedBox(height: 30),

                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LanguageSelectionScreen())),
                      child: Container(
                        width: double.infinity, height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                                colors: [Color(0xFF1F2937), Color(0xFF111827)],
                                begin: Alignment.topCenter, end: Alignment.bottomCenter
                            ),
                            border: Border.all(color: Colors.white.withOpacity(0.1)),
                            boxShadow: [BoxShadow(color: Colors.cyanAccent.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))]
                        ),
                        child: const Center(child: Text("Skip", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if(!isBiometric) CustomKeyboard(onKeyPressed: onKeyPressed, showCheck: false),
        ],
      ),
    );
  }
}