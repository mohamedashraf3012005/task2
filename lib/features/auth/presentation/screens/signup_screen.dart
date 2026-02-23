import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task2/features/auth/presentation/widgets/contact_button.dart';
import 'package:task2/features/auth/presentation/widgets/login_button.dart';
import 'package:task2/features/auth/presentation/widgets/on_boarding_header.dart';
import 'package:task2/features/auth/presentation/widgets/text_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  Future<void> signUp() async {
    print("EMAIL: ${emailController.text}");
    print("PASS: ${passwordController.text}");
    print("Clicked");

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      print("User: ${response.user}");
      print("Session: ${response.session}");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF3F9),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              OnboardingHeader(
                title: "Sign Up",
                subtitle:
                    "Create an account or log in to \n explore about our app",
              ),
              SizedBox(height: 20),
              TextInput(
                title: 'Name',
                hintText: 'Enter your name',
                obscureText: false,
                suffixIcon: Icon(Icons.person),
                controller: null,
              ),
              SizedBox(height: 20),
              TextInput(
                title: 'Email',
                hintText: 'Enter your email',
                obscureText: false,
                suffixIcon: Icon(Icons.email),
                controller: emailController,
              ),
              SizedBox(height: 20),
              TextInput(
                title: 'Password',
                hintText: 'Enter your password',
                obscureText: true,
                suffixIcon: Icon(Icons.lock),
                controller: passwordController,
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: Color(0xFF4A90E2),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                    const Text(
                      "I agree with privacy and policy",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              LoginButton(title: "Sign Up", onPressed: signUp),
              SizedBox(height: 5),
              Text(
                '__________________________Or__________________________',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ContactButton(
                    title: "Google",
                    imagePath: "assets/images/google.png",
                  ),
                  SizedBox(width: 20),
                  ContactButton(
                    title: "Facebook",
                    imagePath: "assets/images/facebook.png",
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(width: 0),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Log In",
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
