import 'package:flutter/material.dart';

class ContactButton extends StatelessWidget {
  final String? title;
  final String? imagePath;
  const ContactButton({super.key, this.title, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Colors.white,
      minWidth: 150,
      height: 50,
      onPressed: () {},
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(imagePath!), width: 20, height: 20),
            SizedBox(width: 15),
            Text(title!, style: TextStyle(fontSize: 16, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
