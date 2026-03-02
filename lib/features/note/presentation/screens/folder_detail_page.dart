import 'package:flutter/material.dart';
import 'package:task2/features/note/presentation/widgets/CardDiary.dart';
import 'package:task2/features/note/presentation/widgets/CreateNewButton.dart';
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
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: Container(
                  height: 130,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade700, Colors.blue.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Personal",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        "12 notes",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      CreateNewButton(
                        title: "Add New Note",
                        firstIcon: Icons.add,
                      ),
                      CardDiary(
                        title: "My Diary",
                        category: "Today is...",
                        color: Colors.blue,
                        date: "Today 10.30 am",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
