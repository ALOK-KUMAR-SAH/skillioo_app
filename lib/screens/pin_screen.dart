import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_widgets.dart';
import 'option_selection_screen.dart';

class PinSelectionScreen extends StatefulWidget {
  const PinSelectionScreen({super.key});
  @override
  State<PinSelectionScreen> createState() => _PinSelectionScreenState();
}

class _PinSelectionScreenState extends State<PinSelectionScreen> {
  bool isBiometric = false;
  String pin = "";
  bool isKeyboardVisible = false;

  // Handle Keyboard Input
  void onKeyPressed(String value) {
    if (isBiometric) return;
    setState(() {
      if (value == 'backspace') {
        if (pin.isNotEmpty) pin = pin.substring(0, pin.length - 1);
      } else if (value == 'check') {
        // Hide Keyboard
        isKeyboardVisible = false;
      } else {
        if (pin.length < 4) pin += value;
      }
    });
  }

  // Handle Button Tap (Continue or Skip)
  void onButtonTap() {
    if (isBiometric) {
      // Biometric is optional -> Skip to Option Selection
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OptionSelectionScreen()),
      );
    } else {
      // Pin is mandatory -> Validate length
      if (pin.length == 4) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OptionSelectionScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter a 4-digit PIN to continue."),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Column(
        children: [
          // Content Area (Scrollable to prevent overflow on small screens)
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    // Logo
                    Image.asset(AppColors.logo, width: 80, height: 80),

                    const SizedBox(height: 20),
                    const Text(
                      "Welcome To Talent Hub",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Choose your preferred authentication method",
                      style: TextStyle(color: AppColors.textGrey, fontSize: 12),
                    ),
                    const SizedBox(height: 30),

                    // --- TOGGLE SWITCH (Pin / Biometric) ---
                    Container(
                      height: 55,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Stack(
                        children: [
                          // Sliding White Background
                          AnimatedAlign(
                            duration: const Duration(milliseconds: 250),
                            alignment: isBiometric
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              width:
                                  (MediaQuery.of(context).size.width - 56) / 2,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                          // Text Labels
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() {
                                    isBiometric = false;
                                    isKeyboardVisible = false;
                                  }),
                                  child: Center(
                                    child: Text(
                                      "Pin",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: !isBiometric
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() {
                                    isBiometric = true;
                                    isKeyboardVisible = false;
                                  }),
                                  child: Center(
                                    child: Text(
                                      "Biometric",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isBiometric
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // --- PIN MODE UI ---
                    if (!isBiometric) ...[
                      const Text(
                        "Set Pin",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // CLICKABLE PIN BOXES
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isKeyboardVisible = true;
                          });
                        },
                        child: Container(
                          color: Colors.transparent, // Ensures tap detection
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(4, (index) {
                              bool isActive =
                                  index == pin.length && isKeyboardVisible;
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    // Highlight border if active or filled
                                    color: isActive || pin.length > index
                                        ? Colors.white
                                        : Colors.transparent,
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: pin.length > index
                                      ? Container(
                                          width: 12,
                                          height: 12,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                        )
                                      : null,
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ]
                    // --- BIOMETRIC MODE UI ---
                    else ...[
                      const Text(
                        "Biometric Authentication",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Touch fingerprint sensor or use Face ID",
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                      const SizedBox(height: 30),
                      const Icon(
                        Icons.fingerprint,
                        size: 90,
                        color: Colors.cyanAccent,
                      ),
                    ],

                    const SizedBox(height: 40),

                    // --- BOTTOM BUTTON ---
                    // Hidden only if in Pin Mode AND Keyboard is visible (to avoid overlapping)
                    if (isBiometric || !isKeyboardVisible)
                      GestureDetector(
                        onTap: onButtonTap,
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF1F2937),
                                Color(0xFF111827),
                              ], // Dark Gradient
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.cyanAccent.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              // Change text dynamically
                              isBiometric ? "Skip" : "Continue",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // --- CUSTOM KEYBOARD ---
          // Only show if NOT in biometric mode AND user clicked the boxes
          if (!isBiometric && isKeyboardVisible)
            CustomKeyboard(onKeyPressed: onKeyPressed, showCheck: true),
        ],
      ),
    );
  }
}
