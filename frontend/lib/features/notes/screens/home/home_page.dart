import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/notes/providers/notesProvider.dart';
import 'package:frontend/features/notes/providers/notesState.dart';
import 'package:frontend/features/notes/screens/home/createNote.dart';
import 'package:frontend/features/notes/screens/home/updateNote.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(notesProvider.notifier).fetchNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notesState = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("My Notes")),
      body: _buildBody(notesState, ref),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Createnote()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(NotesState state, WidgetRef ref) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.error != null) {
      return Center(child: Text(state.error!));
    }

    if (state.notes.isEmpty) {
      return const Center(
        child: Text(
          "No notes yet.\nTap + to create one!",
          textAlign: TextAlign.center,
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(notesProvider.notifier).fetchNotes();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.notes.length,
        itemBuilder: (context, index) {
          final note = state.notes[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Updatenote(note: note)),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(note.title),
                subtitle: Text(
                  note.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  onPressed: () async {
                    final noteState = ref.read(notesProvider.notifier);
                    await noteState.deleteNote(note.id);
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
