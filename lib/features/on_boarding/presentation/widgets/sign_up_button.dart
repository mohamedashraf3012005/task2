import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final String? color;
  final String? colorIcon;

  const SignUpButton({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.colorIcon,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      minWidth: 20,
      color: Color(int.parse(color!)),
      textColor: Colors.black,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: SizedBox(
        width: 270,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Color(int.parse(colorIcon!))),
            SizedBox(width: 8),
            Text(title!),
          ],
        ),
      ),
    );
  }
}
