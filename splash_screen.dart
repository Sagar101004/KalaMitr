import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  // Keep the parameter, but we'll determine the default flow logic here
  // If you always pass false for now, that's fine.
  final bool isLoggedIn; // You might not need this if logic is internal

  const SplashScreen({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      bool userIsActuallyLoggedIn = false; // <--- This should be your real check

      // ignore: dead_code
      if (userIsActuallyLoggedIn) { // Use internal check or widget.isLoggedIn if reliable
        // Navigate to the Main App Screen (Bottom Navigation)
// Use '/home' as defined in main.dart
      } else {
        // Navigate to the Login Screen
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF9F43), // Orange
              Color(0xFFFF6B6B), // Red-Orange
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Make sure assets/kalamitr_logo.png exists in your project
              // and is declared in pubspec.yaml
              Image.asset(
                'assets/kalamitr_logo.png',
                height: 120,
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              const SizedBox(height: 20),
              // Optional: Add App Name Text
            ],
          ),
        ),
      ),
    );
  }
}