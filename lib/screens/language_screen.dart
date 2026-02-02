import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_widgets.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});
  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  int selectedIndex = 0;
  final List<String> languages = ["English", "Hindi", "Marathi", "Kannada", "Telugu"];
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
            const SizedBox(height: 10),
            const Text("Select Your Language", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text("Tell us how you'd like the app to talk to you.", style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.separated(
                itemCount: languages.length,
                separatorBuilder: (c, i) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedIndex = index),
                    child: GlassContainer(
                      height: 60, borderRadius: 16,
                      color: isSelected ? Colors.white.withOpacity(0.2) : Colors.white.withOpacity(0.05),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(children: [Text(languages[index], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)), const Spacer(), if(isSelected) const Icon(Icons.check_circle, color: Color(0xFF6C63FF))]),
                      ),
                    ),
                  );
                },
              ),
            ),
            PrimaryButton(text: "Continue", onTap: (){ ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Setup Complete!"))); }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}