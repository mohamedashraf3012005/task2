import 'package:flutter/material.dart';
import 'package:task2/features/note/presentation/widgets/CustomAppbar.dart';
import 'package:task2/features/note/presentation/widgets/PhotoSection.dart';
import 'package:task2/features/note/presentation/widgets/WriteBoxDiary.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Diary",
        firstIcon: (Icons.arrow_back),
        secondIcon: (Icons.share),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.circle, color: Colors.blue, size: 12),
                SizedBox(width: 8),
                Text(
                  'Today, August 25',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            WriteBoxDiary(),

            const SizedBox(height: 24),

            const Text(
              'Photos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            // photos section
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  PhotoSection(imagePath: "assets/images/1.jpg"),
                  const SizedBox(width: 12),
                  PhotoSection(imagePath: "assets/images/2.jpg"),
                  const SizedBox(width: 12),
                  buildAddPhotoButton(),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Tags section
            const Text(
              'Tags',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                _TagChip(label: 'Personal', color: Colors.blue),
                _TagChip(label: 'Daily', color: Colors.green),
                _TagChip(label: 'Life', color: Colors.purple),
              ],
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      // Bottom Navigation (mock)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: ''),
        ],
      ),
    );
  }

  Widget buildAddPhotoButton() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400, width: 2),
      ),
      child: const Icon(Icons.add_rounded, size: 40, color: Colors.grey),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  final Color color;

  const _TagChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
