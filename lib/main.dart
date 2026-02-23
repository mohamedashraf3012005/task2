import 'package:flutter/material.dart';
import 'package:task2/features/auth/presentation/screens/login_screen.dart';
import 'package:task2/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:task2/features/auth/presentation/screens/signup_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://vmwmmweuxhneputthgem.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZtd21td2V1eGhuZXB1dHRoZ2VtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE4MjE4MjYsImV4cCI6MjA4NzM5NzgyNn0.ArKTo4rvY_b4fkN66bXoXsXXHi47cmlc_cMugW19KBQ",
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}
