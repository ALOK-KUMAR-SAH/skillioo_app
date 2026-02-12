import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';
import 'email_input_screen.dart';

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({super.key});

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  String? _firstNameError;
  String? _lastNameError;

  void _validateAndContinue() {
    setState(() {
      //  Manual validation
      _firstNameError = _firstNameController.text.trim().isEmpty
          ? 'Please enter your first name'
          : _firstNameController.text.trim().length < 2
              ? 'Name must be at least 2 characters'
              : null;

      _lastNameError = _lastNameController.text.trim().isEmpty
          ? 'Please enter your last name'
          : _lastNameController.text.trim().length < 2
              ? 'Name must be at least 2 characters'
              : null;
    });

    //  Only navigate if both fields are valid
    if (_firstNameError == null && _lastNameError == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EmailInputScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Header with back button and step indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  "Step: 1 of 3",
                  style: TextStyle(color: Colors.white54),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "What Should We Call You?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Drop your first and last name so we get it right.",
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
            const SizedBox(height: 40),

            //  First Name Field with Error Display
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlassTextField(
                  hint: "First Name",
                  controller: _firstNameController,
                ),
                if (_firstNameError != null) ...[
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      _firstNameError!,
                      style: TextStyle(
                        color: Colors.red[400],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 20),

            //  Last Name Field with Error Display
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlassTextField(
                  hint: "Last Name",
                  controller: _lastNameController,
                ),
                if (_lastNameError != null) ...[
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      _lastNameError!,
                      style: TextStyle(
                        color: Colors.red[400],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),

            const Spacer(),
            PrimaryButton(
              text: "Continue",
              onTap: _validateAndContinue,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
}
