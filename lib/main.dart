import 'dart:async';
import 'dart:ui'; // Required for ImageFilter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  setSystemUIOverlayStyle();
  runApp(const SkilliooApp());
}

void setSystemUIOverlayStyle() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.black, // Match bottom of gradient
    systemNavigationBarIconBrightness: Brightness.light,
  ));
}

// ------------------- THEME & CONSTANTS -------------------
class AppColors {
  // Main Background Gradients
  static const Color bgTop = Color(0xFF4A00E0); // Deep Purple
  static const Color bgBottom = Color(0xFF000000); // Black

  // Brand Colors
  static const Color primaryCyan = Color(0xFF00E5FF);
  static const Color cardGreen = Color(0xFFC6FF00);
  static const Color textGrey = Colors.white54;

  // Standard UI Colors
  static const Color glassWhite = Color(0x1AFFFFFF); // 10% White
  static const Color glassBorder = Color(0x33FFFFFF); // 20% White
}

class SkilliooApp extends StatelessWidget {
  const SkilliooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skillioo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Roboto', color: Colors.white),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// ==============================================================================
// 1. SPLASH SCREEN (Typewriter Animation)
// ==============================================================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String textToShow = "";
  String fullText = "Skillioo";
  int index = 0;

  @override
  void initState() {
    super.initState();
    startTypewriterAnimation();
  }

  void startTypewriterAnimation() {
    Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (index < fullText.length) {
        setState(() {
          textToShow += fullText[index];
          index++;
        });
      } else {
        timer.cancel();
        // Wait 1 second then navigate
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const WelcomeScreen(),
              transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
              transitionDuration: const Duration(milliseconds: 800),
            ),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF00E5FF), Color(0xFF2979FF)]),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 30, spreadRadius: 5)
                  ]
              ),
              child: const Icon(Icons.play_arrow_rounded, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 30),
            // Typewriter Text
            Text(
              textToShow,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                fontFamily: 'Courier',
              ),
            ),
            const SizedBox(height: 10),
            if (index == fullText.length)
              const FadeInText(text: "INDIA'S FIRST TALENT HUB")
          ],
        ),
      ),
    );
  }
}

// ==============================================================================
// 2. WELCOME SCREEN (Card Stack Snapshot)
// ==============================================================================
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Column(
        children: [
          const SizedBox(height: 50),

          // Top Logo
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.cyanAccent, width: 1.5),
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.black.withOpacity(0.3)
                ),
                child: const Icon(Icons.play_circle_fill, size: 30, color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text("Skillioo", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1)),
              const Text("INDIA'S FIRST TALENT HUB", style: TextStyle(fontSize: 8, color: Colors.cyanAccent)),
            ],
          ),

          const Spacer(),

          // Card Stack
          SizedBox(
            height: 320,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                _buildCard(angle: -0.15, scale: 0.85, offsetX: -90, color: AppColors.cardGreen.withOpacity(0.3), image: 'https://images.unsplash.com/photo-1516280440614-6697288d5d38?auto=format&fit=crop&q=80&w=300'),
                _buildCard(angle: 0.15, scale: 0.85, offsetX: 90, color: AppColors.cardGreen.withOpacity(0.3), image: 'https://images.unsplash.com/photo-1493225255756-d9584f8606e9?auto=format&fit=crop&q=80&w=300'),
                _buildCard(angle: 0, scale: 1.0, offsetX: 0, color: Colors.cyanAccent.withOpacity(0.4), isCenter: true, image: 'https://images.unsplash.com/photo-1520423465871-08636dd766c3?auto=format&fit=crop&q=80&w=300'),
              ],
            ),
          ),

          const Spacer(),

          // Bottom Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: Column(
              children: [
                const Text("Welcome!", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 16),
                const Text(
                  "We bring together a community of like-minded individuals and connections for top talent. Showcase your skills, build your network.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
                ),
                const SizedBox(height: 30),

                // Let's Go Button (Special Style for this screen)
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PhoneNumberScreen()));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                            colors: [Color(0xFF2E3A59), Color(0xFF6200EA)],
                            begin: Alignment.centerLeft, end: Alignment.centerRight
                        ),
                        boxShadow: [BoxShadow(color: Colors.purple.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))],
                        border: Border.all(color: Colors.white.withOpacity(0.1))
                    ),
                    child: const Center(child: Text("Let's Go", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required double angle, required double scale, required double offsetX, required Color color, required String image, bool isCenter = false}) {
    return Transform.translate(
      offset: Offset(offsetX, 0),
      child: Transform.rotate(
        angle: angle,
        child: Transform.scale(
          scale: scale,
          child: Container(
            width: 180, height: 240,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: color, width: 2),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20, spreadRadius: 2)],
                image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)
            ),
            child: Stack(
              children: [
                Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.8)]))),
                Positioned(
                  top: 15, left: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text("2.5M Views", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)), Text("2K Likes", style: TextStyle(fontSize: 7, color: Colors.white70))]),
                  ),
                ),
                Positioned(
                  bottom: 15, left: 15, right: 15,
                  child: Column(
                    children: [
                      Row(children: const [CircleAvatar(radius: 8, backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=5')), SizedBox(width: 5), Text("Lisa Singer", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))]),
                      if(isCenter) ...[
                        const SizedBox(height: 8),
                        Container(height: 3, width: double.infinity, decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(2)), child: FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: 0.6, child: Container(color: Colors.cyanAccent))),
                        const SizedBox(height: 2),
                        const Align(alignment: Alignment.centerRight, child: Text("1:25", style: TextStyle(fontSize: 7))),
                      ]
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==============================================================================
// 3. PHONE NUMBER SCREEN
// ==============================================================================
class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  String phoneNumber = "";
  bool isError = false;

  void onKeyPressed(String value) {
    setState(() {
      isError = false;
      if (value == 'backspace') {
        if (phoneNumber.isNotEmpty) phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
      } else if (value == 'check') {
        if (phoneNumber.length == 10) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const OTPScreen()));
        } else {
          isError = true;
        }
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
                  const SizedBox(height: 8),
                  const Text("Promise we'll only use it to send your OTP.", style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                  const SizedBox(height: 40),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1B2E),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isError ? Colors.red : Colors.transparent),
                    ),
                    child: Row(
                      children: [
                        const Text("91+  ", style: TextStyle(color: Colors.white54, fontSize: 20)),
                        Text(
                          phoneNumber.isEmpty ? "0000000000" : phoneNumber,
                          style: TextStyle(fontSize: 20, letterSpacing: 1.5, color: phoneNumber.isEmpty ? Colors.white12 : Colors.white),
                        ),
                      ],
                    ),
                  ),
                  if(isError) const Padding(padding: EdgeInsets.only(top: 10), child: Text("Invalid number.", style: TextStyle(color: Colors.red, fontSize: 12))),

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

// ==============================================================================
// 4. OTP SCREEN
// ==============================================================================
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
                  const SizedBox(height: 8),
                  const Text("Peep your phone and enter the code we just sent.", style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
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

// ==============================================================================
// 5. SUCCESS SCREEN
// ==============================================================================
class VerificationSuccessScreen extends StatefulWidget {
  const VerificationSuccessScreen({super.key});
  @override
  State<VerificationSuccessScreen> createState() => _VerificationSuccessScreenState();
}

class _VerificationSuccessScreenState extends State<VerificationSuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PinSelectionScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent.withOpacity(0.2), border: Border.all(color: Colors.blueAccent, width: 2)),
              child: const Icon(Icons.check, size: 50, color: Colors.blueAccent),
            ),
            const SizedBox(height: 30),
            const Text("Verification Successful!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// ==============================================================================
// 6. PIN / BIOMETRIC SCREEN
// ==============================================================================
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
              child: Column(
                children: [
                  const Icon(Icons.hub, size: 50, color: Colors.white),
                  const SizedBox(height: 20),
                  const Text("Welcome To Talent Hub", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text("Choose your preferred authentication method", style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
                  const SizedBox(height: 30),

                  // Toggle Switch
                  Container(
                    height: 50, padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(25)),
                    child: Stack(
                      children: [
                        AnimatedAlign(
                          duration: const Duration(milliseconds: 250),
                          alignment: isBiometric ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(width: (MediaQuery.of(context).size.width - 56) / 2, decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(25))),
                        ),
                        Row(children: [
                          Expanded(child: GestureDetector(onTap: () => setState(() => isBiometric = false), child: const Center(child: Text("Pin", style: TextStyle(fontWeight: FontWeight.bold))))),
                          Expanded(child: GestureDetector(onTap: () => setState(() => isBiometric = true), child: const Center(child: Text("Biometric", style: TextStyle(fontWeight: FontWeight.bold))))),
                        ])
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  if (!isBiometric) ...[
                    const Text("Set Pin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(4, (index) => Container(margin: const EdgeInsets.symmetric(horizontal: 10), width: 16, height: 16, decoration: BoxDecoration(color: pin.length > index ? Colors.white : Colors.white24, shape: BoxShape.circle)))),
                  ] else ...[
                    const Text("Biometric Authentication", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 20),
                    const Icon(Icons.fingerprint, size: 80, color: Colors.blueAccent),
                  ],

                  const Spacer(),
                  PrimaryButton(text: isBiometric ? "Continue" : "Skip", onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LanguageSelectionScreen()))),
                ],
              ),
            ),
          ),
          if(!isBiometric) CustomKeyboard(onKeyPressed: onKeyPressed, showCheck: false),
        ],
      ),
    );
  }
}

// ==============================================================================
// 7. LANGUAGE SELECTION SCREEN
// ==============================================================================
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

// ==============================================================================
// HELPERS
// ==============================================================================

class FadeInText extends StatefulWidget {
  final String text;
  const FadeInText({super.key, required this.text});
  @override
  State<FadeInText> createState() => _FadeInTextState();
}
class _FadeInTextState extends State<FadeInText> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..forward();
  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _ctrl, child: Text(widget.text, style: const TextStyle(fontSize: 10, color: Colors.white54, letterSpacing: 2)));
  }
}

class GlassContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final Widget? child;
  final Color? color;
  const GlassContainer({super.key, this.width, this.height, this.borderRadius = 24, this.child, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, height: height,
      decoration: BoxDecoration(color: color ?? AppColors.glassWhite, borderRadius: BorderRadius.circular(borderRadius), border: Border.all(color: AppColors.glassBorder, width: 1)),
      child: child,
    );
  }
}

class GradientScaffold extends StatelessWidget {
  final Widget child;
  const GradientScaffold({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity, height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: [AppColors.bgTop, Colors.black, Colors.black],
              stops: [0.0, 0.4, 1.0]
          ),
        ),
        child: SafeArea(child: child),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const PrimaryButton({super.key, required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [BoxShadow(color: const Color(0xFF6366F1).withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 5))]
        ),
        child: Center(child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))),
      ),
    );
  }
}

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;
  final bool showCheck;
  const CustomKeyboard({super.key, required this.onKeyPressed, this.showCheck = true});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF151515),
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRow(['1', '2', '3', '-']),
          _buildRow(['4', '5', '6', '_']),
          _buildRow(['7', '8', '9', 'del']),
          _buildRow([',', '0', '.', 'check']),
        ],
      ),
    );
  }
  Widget _buildRow(List<String> keys) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: keys.map((key) => _buildKey(key)).toList()),
    );
  }
  Widget _buildKey(String key) {
    bool isAction = key == 'check';
    bool isDelete = key == 'del';
    bool isSpacer = key == '-' || key == '_' || key == ',' || key == '.';
    return GestureDetector(
      onTap: () { if(isSpacer && key != '.') return; if (isDelete) { onKeyPressed('backspace'); } else { onKeyPressed(key); } },
      child: Container(
        width: 80, height: 50, alignment: Alignment.center,
        decoration: BoxDecoration(color: isAction ? const Color(0xFF4C6EF5) : Colors.transparent, borderRadius: BorderRadius.circular(12)),
        child: isDelete ? const Icon(Icons.backspace_outlined, size: 22, color: Colors.white70) : isAction ? const Icon(Icons.check, color: Colors.white) : Text(key, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: isSpacer ? Colors.white24 : Colors.white)),
      ),
    );
  }
}