import 'package:flutter/material.dart';
import 'package:task2/features/note/presentation/widgets/CardDiary.dart';
import 'package:task2/features/note/presentation/widgets/AddNewNote.dart';
import 'package:task2/features/note/presentation/widgets/CustomAppbar.dart';

class FolderDetailPage extends StatelessWidget {
  const FolderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Personal",
        firstIcon: Icons.arrow_back,
        secondIcon: Icons.more_vert,
        colorText: Color(0xff002D95),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            AddNewNote(title: "Personal", subtitle: "12 Note"),

            const SizedBox(height: 24),
            const Text(
              "Notes",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  CardDiary(
                    title: "My Diary",
                    category: "Today was a Great day",
                    color: const Color(0xff216AFD),
                    date: "25/6",
                  ),
                  CardDiary(
                    title: "Shopping List",
                    category: "Milk, Eggs, Bread...",
                    color: const Color(0xffFD534A),
                    date: "25/6",
                  ),
                  CardDiary(
                    title: "Travel Plan",
                    category: "Visit Paris, Rome...",
                    color: const Color(0xffF6A135),
                    date: "24/6",
                  ),
                  CardDiary(
                    title: "Birth Day Ideas",
                    category: "Gift, Cake, Party...",
                    color: const Color(0xffE9A03E),
                    date: "20/8/2022",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xff1660FB),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
