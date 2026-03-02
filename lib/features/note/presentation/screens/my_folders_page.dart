import 'package:flutter/material.dart';
import 'package:task2/features/note/presentation/widgets/CardDiary.dart';
import 'package:task2/features/note/presentation/widgets/CardFolders.dart';
import 'package:task2/features/note/presentation/widgets/CreateNewButton.dart';
import 'package:task2/features/note/presentation/widgets/CustomAppbar.dart';

class MyFoldersPage extends StatelessWidget {
  const MyFoldersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FA),
      appBar: CustomAppBar(
        title: 'My Folders',
        firstIcon: Icons.menu,
        secondIcon: Icons.notifications_outlined,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(
              constraints: const BoxConstraints(maxHeight: 50),
              leading: const Icon(Icons.search),
              trailing: [
                IconButton(icon: const Icon(Icons.mic), onPressed: () {}),
              ],
              hintText: 'Search...',
              elevation: const WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(Colors.grey.shade200),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(height: 20),
            CreateNewButton(title: 'Create New Folder', firstIcon: Icons.add),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: ScrollController(),
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                children: [
                  Row(
                    children: [
                      CardFolders(
                        title: 'Personal',
                        notesCount: '12 notes',
                        color: Color(0xFF0F5AFE),
                      ),
                      SizedBox(width: 16),
                      CardFolders(
                        title: 'Work',
                        notesCount: '8 notes',
                        color: Color(0xFF237A45),
                      ),
                      SizedBox(width: 16),
                      CardFolders(
                        title: 'Travel',
                        notesCount: '5 notes',
                        color: Color(0xFF4CAF50),
                      ),
                      SizedBox(width: 16),
                      CardFolders(
                        title: 'Education',
                        notesCount: '3 notes',
                        color: Color(0xFF9C27B0),
                      ),
                      SizedBox(width: 16),
                      CardFolders(
                        title: 'Health',
                        notesCount: '7 notes',
                        color: Color(0xFFFF9800),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      CardFolders(
                        title: 'Shopping',
                        notesCount: '15 notes',
                        color: Color(0xFF753AE0),
                      ),
                      SizedBox(width: 16),
                      CardFolders(
                        title: 'Ideas',
                        notesCount: '6 notes',
                        color: Color(0xFFFDA643),
                      ),
                      SizedBox(width: 16),
                      CardFolders(
                        title: 'Projects',
                        notesCount: '6 notes',
                        color: Colors.indigo.shade100,
                      ),
                      SizedBox(width: 16),
                      CardFolders(
                        title: 'Favorites',
                        notesCount: '9 notes',
                        color: Colors.pink.shade100,
                      ),
                      SizedBox(width: 16),
                      CardFolders(
                        title: 'Archive',
                        notesCount: '1 note',
                        color: Colors.grey.shade100,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 4),
                Text(
                  'Recent Notes',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF2753AD),
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Color(0xFF2753AD),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            CardDiary(
              title: 'Shopping List',
              category: 'Personal',
              color: Colors.red,
              date: 'Today',
            ),
            SizedBox(height: 3),
            CardDiary(
              title: 'Meeting Summary',
              category: 'Work',
              color: Colors.green,
              date: 'Yesterday',
            ),
            SizedBox(height: 3),
            CardDiary(
              title: 'Lecture 5',
              category: 'Study',
              color: Color(0xff9839DC),
              date: '2 days ago',
            ),
            SizedBox(height: 3),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Color(0xff2C6CFE),
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
