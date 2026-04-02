import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/features/note/data/models/note_model.dart';
import 'package:task2/features/note/presentation/cubit/note_cubit.dart';
import 'package:task2/features/note/presentation/cubit/note_state.dart';
import 'package:task2/features/note/presentation/widgets/card_diary.dart';
import 'package:task2/features/note/presentation/widgets/add_new_note.dart';
import 'package:task2/features/note/presentation/widgets/custom_appbar.dart';

class FolderDetailPage extends StatelessWidget {
  final String folderName;
  const FolderDetailPage({super.key, required this.folderName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) {
        String? folderId;
        if (state is NotesLoaded) {
          try {
            folderId = state.folders.firstWhere((f) => f.name == folderName).id;
          } catch (_) {}
        }

        final folderNotes = state is NotesLoaded
            ? state.notes.where((n) => n.folder == folderName).toList()
            : <NoteModel>[];

        return Scaffold(
          appBar: CustomAppBar(
            title: folderName,
            firstIcon: Icons.arrow_back,
            actions: [
              if (folderId != null)
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Color(0xff002D95)),
                  onSelected: (value) {
                    if (value == 'delete') {
                      _showDeleteFolderDialog(context, folderId!, folderName);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete Folder', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
            colorText: const Color(0xff002D95),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                if (state is NoteLoading)
                  const Expanded(child: Center(child: CircularProgressIndicator()))
                else ...[
                  AddNewNote(title: folderName, subtitle: "${folderNotes.length} Notes"),
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
                    child: folderNotes.isEmpty
                        ? const Center(child: Text("No notes in this folder."))
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: folderNotes.length,
                            itemBuilder: (context, index) {
                              final note = folderNotes[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: CardDiary(
                                  note: note,
                                  color: const Color(0xff216AFD),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: const Color(0xff1660FB),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        );
      },
    );
  }

  void _showDeleteFolderDialog(BuildContext context, String id, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Folder'),
        content: Text('Are you sure you want to delete "$title"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<NoteCubit>().deleteFolder(id);
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // go back to list
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
