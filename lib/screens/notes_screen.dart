import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _contentController,
                        decoration: const InputDecoration(
                          labelText: 'Note',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (_contentController.text.isNotEmpty) {
                          context.read<NoteProvider>().add(
                                Note(
                                  id: DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString(),
                                  title: _titleController.text.trim(),
                                  content: _contentController.text,
                                ),
                              );
                          _titleController.clear();
                          _contentController.clear();
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<NoteProvider>(
              builder: (context, noteProvider, child) {
                if (noteProvider.notes.isEmpty) {
                  return const Center(child: Text('No notes yet'));
                }
                return ListView.builder(
                  itemCount: noteProvider.notes.length,
                  itemBuilder: (context, index) {
                    final note = noteProvider.notes[index];
                    return ListTile(
                      title: Text(
                        note.title.isNotEmpty ? note.title : note.content,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: note.title.isNotEmpty
                          ? Text(
                              note.content,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          : null,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit_outlined),
                            tooltip: 'Edit',
                            onPressed: () =>
                                _showEditDialog(context, noteProvider, note),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            tooltip: 'Delete',
                            onPressed: () => noteProvider.delete(note.id),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, NoteProvider noteProvider, Note note) {
    final titleEditController = TextEditingController(text: note.title);
    final contentEditController = TextEditingController(text: note.content);
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleEditController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: contentEditController,
              autofocus: true,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Note',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final content = contentEditController.text.trim();
              if (content.isNotEmpty) {
                noteProvider.updateNote(
                  note.id,
                  title: titleEditController.text.trim(),
                  content: content,
                );
              }
              Navigator.pop(dialogContext);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    ).then((_) {
      titleEditController.dispose();
      contentEditController.dispose();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
