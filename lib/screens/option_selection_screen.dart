import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';
import 'language_screen.dart';
import 'profile_type_screen.dart'; // Import Profile Creation Flow

class OptionSelectionScreen extends StatelessWidget {
  const OptionSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              "Select Any One Option From Below",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Option 1: Select App Language
            _buildOptionCard(
              context,
              icon: Icons.translate,
              text: "Select App Language",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LanguageSelectionScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Option 2: Create Profile (Navigate to Profile Flow)
            _buildOptionCard(
              context,
              icon: Icons.person_add_alt_1,
              text: "Create Profile",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileTypeScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Option 3: Dashboard
            _buildOptionCard(
              context,
              icon: Icons.dashboard_customize,
              text: "Proceed To Dashboard",
              onTap: () {
                // Placeholder for Dashboard
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Navigating to Dashboard...")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Card Widget for Options
  Widget _buildOptionCard(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1), // Glassmorphism effect
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: const Color(0xFF00E5FF), size: 24),
            ),
            const SizedBox(width: 20),
            // Text Label
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
