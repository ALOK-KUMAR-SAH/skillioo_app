import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_widgets.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});
  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  int selectedIndex = 0;
  final List<String> languages = [
    "English",
    "Hindi",
    "Marathi",
    "Kannada",
    "Telugu",
    "Malayalam",
    "Tamil"
  ];

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Back button returns to Option Selection
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(height: 10),
            const Text(
              "Select Your Language",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Tell us how you'd like the app to talk to you.",
              style: TextStyle(color: AppColors.textGrey, fontSize: 12),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: ListView.separated(
                itemCount: languages.length,
                separatorBuilder: (c, i) => const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedIndex = index),
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        // Selected: Lighter Grey/White gradient, Unselected: Dark
                        color: isSelected
                            ? Colors.white.withOpacity(0.25)
                            : const Color(0xFF1E1E2C),
                        borderRadius: BorderRadius.circular(30), // Pill shape
                        border: isSelected
                            ? Border.all(color: Colors.white30, width: 1)
                            : Border.all(color: Colors.transparent),
                      ),
                      child: Row(
                        children: [
                          Text(
                            languages[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isSelected ? Colors.white : Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Continue Button with specific gradient from Figma
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Language Selected!")),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF1F2937),
                      Color(0xFF111827),
                    ], // Dark button
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
