import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? firstIcon;
  final List<Widget>? actions;
  final Color? colorText;
  final VoidCallback? onFirstIconPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.firstIcon,
    this.actions,
    this.colorText,
    this.onFirstIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: firstIcon != null
          ? IconButton(
              icon: Icon(firstIcon),
              onPressed: onFirstIconPressed ?? () => Navigator.pop(context),
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: colorText ?? Colors.black,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
