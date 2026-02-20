import 'package:flutter/material.dart';
import 'package:task2/features/auth/presentation/widgets/contact_button.dart';
import 'package:task2/features/auth/presentation/widgets/login_button.dart';
import 'package:task2/features/auth/presentation/widgets/on_boarding_header.dart';
import 'package:task2/features/auth/presentation/widgets/text_input.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF3F9),
      body: Center(
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
            ),
            SizedBox(height: 20),
            TextInput(
              title: 'Email',
              hintText: 'Enter your email',
              obscureText: false,
              suffixIcon: Icon(Icons.email),
            ),
            SizedBox(height: 20),
            TextInput(
              title: 'Password',
              hintText: 'Enter your password',
              obscureText: true,
              suffixIcon: Icon(Icons.lock),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            LoginButton(title: "Sign Up"),
            SizedBox(height: 15),
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
    );
  }
}
