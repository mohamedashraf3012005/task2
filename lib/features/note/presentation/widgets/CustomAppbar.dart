import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  IconData? firstIcon;
  IconData? secondIcon;
  Color? colorText;

  CustomAppBar({
    super.key,
    required this.title,
    this.firstIcon,
    this.secondIcon,
    this.colorText,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(icon: Icon(firstIcon), onPressed: () {}),
      titleSpacing: 95,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: colorText ?? Colors.black,
        ),
      ),
      actions: [
        Stack(
          children: [IconButton(icon: Icon(secondIcon), onPressed: () {})],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
