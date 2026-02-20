import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String? title;
  const LoginButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      minWidth: 20,
      color: Colors.blue,
      textColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: SizedBox(
        width: 320,
        height: 50,
        child: Center(
          child: Text(
            title!,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
