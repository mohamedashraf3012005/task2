import 'package:flutter/material.dart';
import 'package:task2/features/auth/presentation/screens/login_screen.dart';
import 'package:task2/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:task2/features/auth/presentation/screens/signup_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
