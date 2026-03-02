import 'package:flutter/material.dart';

class ConnectWithButton extends StatelessWidget {
  final String imagePath;
  const ConnectWithButton({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Image(image: AssetImage(imagePath), height: 40, width: 40),
    );
  }
}
