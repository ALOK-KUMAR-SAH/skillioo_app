import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'utils/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Error boundary
  setSystemUIOverlayStyle();
  runApp(const SkilliooApp());
}

void setSystemUIOverlayStyle() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}

class SkilliooApp extends StatelessWidget {
  const SkilliooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skillioo - Talent Hub',
      theme: ThemeData(
        useMaterial3: true, // Modern Material 3
        colorScheme: ColorScheme.dark(
          primary: AppColors.primaryCyan,
          surface: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Inter', // Modern font
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      builder: (context, child) {
        // Prevent text scaling issues
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(1.0)),
          child: child!,
        );
      },
      home: const SplashScreen(),
    );
  }
}
