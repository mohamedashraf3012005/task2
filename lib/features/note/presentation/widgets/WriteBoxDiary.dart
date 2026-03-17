import 'package:flutter/material.dart';

class WriteBoxDiary extends StatelessWidget {
  const WriteBoxDiary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Today was a great day!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'I completed all my day tasks and had a productive meeting '
            'with the team. In the evening, I went to the gym and felt '
            'great afterwards. Losing great guilwards\n\n'
            'Second to tomorrow!',
            style: TextStyle(fontSize: 16, height: 1.45, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
