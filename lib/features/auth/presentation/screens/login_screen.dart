import 'package:flutter/material.dart';
import 'package:task2/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:task2/features/auth/presentation/screens/signup_screen.dart';
import 'package:task2/features/auth/presentation/widgets/contact_button.dart';
import 'package:task2/features/auth/presentation/widgets/login_button.dart';
import 'package:task2/features/auth/presentation/widgets/on_boarding_header.dart';
import 'package:task2/features/auth/presentation/widgets/text_input.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isChecked = false;
  bool isLoading = false;

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    final response = await Supabase.instance.client.auth.signInWithPassword(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (response.session != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login successful!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF3F9),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              OnboardingHeader(
                title: "Login",
                subtitle: "Login to access your account",
              ),
              const SizedBox(height: 20),
              TextInput(
                title: 'Email',
                hintText: 'Enter your email',
                obscureText: false,
                suffixIcon: const Icon(Icons.email),
                controller: emailController,
              ),
              const SizedBox(height: 20),
              TextInput(
                title: 'Password',
                hintText: 'Enter your password',
                obscureText: true,
                suffixIcon: const Icon(Icons.lock),
                controller: passwordController,
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: const Color(0xFF4A90E2),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                    const Text(
                      "Remember Me",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              LoginButton(
                title: isLoading ? "Logging in..." : "Log in",
                onPressed: isLoading ? null : login,
              ),
              const SizedBox(height: 10),
              const Text(
                '__________________________Or__________________________',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ContactButton(
                    title: "Google",
                    imagePath: "assets/images/google.png",
                  ),
                  const SizedBox(width: 20),
                  ContactButton(
                    title: "Facebook",
                    imagePath: "assets/images/facebook.png",
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(width: 0),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
