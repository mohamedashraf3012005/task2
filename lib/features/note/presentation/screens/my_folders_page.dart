import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task2/features/auth/sign_in/presentation/cubit/login_cubit.dart';
import 'package:task2/features/auth/sign_in/presentation/screens/login_screen.dart';
import 'package:task2/features/note/data/models/folder_model.dart';
import 'package:task2/features/note/presentation/cubit/note_cubit.dart';
import 'package:task2/features/note/presentation/cubit/note_state.dart';
import 'package:task2/features/note/presentation/screens/add_edit_note_page.dart';
import 'package:task2/features/note/presentation/widgets/card_diary.dart';
import 'package:task2/features/note/presentation/widgets/card_folders.dart';
import 'package:task2/features/note/presentation/widgets/create_new_button.dart';
import 'package:task2/features/note/presentation/widgets/custom_appbar.dart';

class MyFoldersPage extends StatelessWidget {
  MyFoldersPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8F8FA),
      appBar: CustomAppBar(
        title: 'My Folders',
        firstIcon: Icons.menu,
        onFirstIconPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) async {
              if (value == 'logout') {
                await context.read<LoginCubit>().logout();
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Logout', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
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
            CreateNewButton(
              title: 'Create New Folder',
              firstIcon: Icons.add,
              onPressed: () {
                _showAddFolderDialog(context);
              },
            ),
            const SizedBox(height: 24),
            BlocBuilder<NoteCubit, NoteState>(
              builder: (context, state) {
                if (state is NotesLoaded) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: state.folders.map((folder) {
                        final notesCount = state.notes
                            .where((n) => n.folder == folder.name)
                            .length;
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: CardFolders(
                            id: folder.id,
                            title: folder.name,
                            notesCount: '$notesCount notes',
                            color: Color(
                              int.parse(
                                folder.color.replaceFirst('#', '0xFF'),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
                return const SizedBox(height: 110);
              },
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
            BlocBuilder<NoteCubit, NoteState>(
              builder: (context, state) {
                if (state is NoteLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NotesLoaded) {
                  if (state.notes.isEmpty) {
                    return const Center(child: Text("No notes yet. Create your first note!"));
                  }
                  return Column(
                    children: state.notes.take(5).map((note) {
                      final folder = state.folders.firstWhere(
                        (f) => f.name == note.folder,
                        orElse: () => state.folders.isNotEmpty
                            ? state.folders[0]
                            : FolderModel(
                                id: '',
                                name: 'Default',
                                color: '#216AFD',
                                userId: '',
                                createdAt: DateTime.now(),
                              ),
                      );
                      final folderColor = Color(
                        int.parse(folder.color.replaceFirst('#', '0xFF')),
                      );

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CardDiary(
                          note: note,
                          color: folderColor,
                        ),
                      );
                    }).toList(),
                  );
                } else if (state is NoteError) {
                  return Center(child: Text("Error: ${state.message}"));
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xff2C6CFE)),
              accountName: Text(
                Supabase.instance.client.auth.currentUser?.userMetadata?['name'] ?? "User Name",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: Text(
                Supabase.instance.client.auth.currentUser?.email ?? "user@example.com",
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: Color(0xff2C6CFE)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('My Folders'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.star_outline),
              title: const Text('Favorites'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.archive_outlined),
              title: const Text('Archive'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () {},
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () async {
                await context.read<LoginCubit>().logout();
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xff2C6CFE),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditNotePage()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddFolderDialog(BuildContext context) {
    final controller = TextEditingController();
    final List<String> folderColors = [
      '#216AFD', // Primary Blue
      '#7E57C2', // Purple
      '#EF5350', // Red
      '#66BB6A', // Green
      '#FFB300', // Amber
      '#EC407A', // Pink
      '#26C6DA', // Cyan
      '#FF7043', // Deep Orange
    ];
    String selectedHex = folderColors[0];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text(
              "New Folder",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Folder Name",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.folder_outlined),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Choose Color",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 50,
                    width: double.maxFinite,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: folderColors.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final colorHex = folderColors[index];
                        final color = Color(
                          int.parse(colorHex.replaceFirst('#', '0xFF')),
                        );
                        final isSelected = selectedHex == colorHex;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedHex = colorHex;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: isSelected
                                  ? Border.all(color: Colors.black, width: 2.5)
                                  : null,
                              boxShadow: [
                                if (isSelected)
                                  BoxShadow(
                                    color: color.withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                              ],
                            ),
                            child: isSelected
                                ? const Icon(Icons.check, color: Colors.white, size: 20)
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff216AFD),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    context.read<NoteCubit>().addFolder(
                          controller.text,
                          selectedHex,
                        );
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Create",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
