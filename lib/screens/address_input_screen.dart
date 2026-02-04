import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';

class AddressInputScreen extends StatelessWidget {
  const AddressInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Text(
                          "Step: 3 of 3",
                          style: TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Enter Your Address",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Helps us personalize things for you.",
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),

                    const SizedBox(height: 30),

                    // Inputs
                    const GlassTextField(hint: "Full Address...", maxLines: 3),
                    const SizedBox(height: 15),

                    Row(
                      children: const [
                        Expanded(child: GlassTextField(hint: "City")),
                        SizedBox(width: 15),
                        Expanded(child: GlassTextField(hint: "State")),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: const [
                        Expanded(child: GlassTextField(hint: "Country")),
                        SizedBox(width: 15),
                        Expanded(
                          child: GlassTextField(
                            hint: "Pincode",
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Fetch Location Button
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Fetching GPS Location..."),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.my_location,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Fetch My Location",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Button
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: PrimaryButton(
              text: "Continue",
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Profile Created Successfully!"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
