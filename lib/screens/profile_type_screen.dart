import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';
import 'name_input_screen.dart';

class ProfileTypeScreen extends StatefulWidget {
  const ProfileTypeScreen({super.key});
  @override
  State<ProfileTypeScreen> createState() => _ProfileTypeScreenState();
}

class _ProfileTypeScreenState extends State<ProfileTypeScreen> {
  int selectedIndex = -1; // -1 means nothing selected yet

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(height: 20),
            const Text(
              "Choose Your Profile Type.",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Going solo or rolling with a group? Pick your vibe.",
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),

            const SizedBox(height: 40),

            // Selection Cards
            Row(
              children: [
                _buildOptionCard(
                  0,
                  "Individual",
                  "Build fame for showcasing individual creativity.",
                  Icons.person,
                ),
                const SizedBox(width: 15),
                _buildOptionCard(
                  1,
                  "Group",
                  "Collaborating with talent? Create a group profile.",
                  Icons.group,
                ),
              ],
            ),

            const Spacer(),

            // Continue Button
            PrimaryButton(
              text: "Continue",
              onTap: () {
                if (selectedIndex != -1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NameInputScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select a profile type"),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    int index,
    String title,
    String subtitle,
    IconData icon,
  ) {
    bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedIndex = index),
        child: Container(
          height: 240,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            // Highlight selected card with gradient and border
            color: isSelected
                ? const Color(0xFF6200EA).withOpacity(0.2)
                : const Color(0xFF1E1E2C),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? const Color(0xFF00E5FF) : Colors.transparent,
              width: 2,
            ),
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      const Color(0xFF6200EA).withOpacity(0.5),
                      Colors.transparent,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Placeholder
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(12),
                  // If you have images, use: image: DecorationImage(image: AssetImage('assets/img.png'))
                ),
                child: Icon(
                  icon,
                  color: isSelected ? Colors.white : Colors.white24,
                  size: 50,
                ),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white54,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
