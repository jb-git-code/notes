import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/auth/providers/authprovider.dart';
import 'package:frontend/features/constants/appColors.dart';
import 'package:frontend/features/constants/appTextStyles.dart';
import 'package:frontend/features/notes/providers/notesProvider.dart';
import 'package:frontend/features/notes/providers/notesState.dart';
import 'package:frontend/features/notes/screens/home/createNote.dart';
import 'package:frontend/features/notes/screens/home/updateNote.dart';
import 'package:frontend/features/notes/widgets/noteCard.dart';

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

  void _logOut() async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Logout?', style: AppTextStyles.headingSmall),
        content: Text('This will log you out', style: AppTextStyles.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(
              'Yes',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.danger,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notesState = ref.watch(notesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          notesState.notes.isEmpty
              ? "My Notes"
              : "My Notes (${notesState.notes.length})",
          style: AppTextStyles.headingSmall,
        ),
        iconTheme: const IconThemeData(color: AppColors.text),
        actions: [
          IconButton(onPressed: _logOut, icon: Icon(Icons.logout_rounded)),
        ],
      ),
      body: _buildBody(notesState, ref),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
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
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (state.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                color: AppColors.danger,
                size: 40,
              ),
              const SizedBox(height: 12),
              Text(
                state.error!,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => ref.read(notesProvider.notifier).fetchNotes(),
                child: Text(
                  "Retry",
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (state.notes.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sticky_note_2_outlined,
              size: 64,
              color: AppColors.accent.withOpacity(0.6),
            ),
            const SizedBox(height: 16),
            Text("No notes yet", style: AppTextStyles.headingSmall),
            const SizedBox(height: 4),
            Text(
              "Tap + to create your first one",
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        await ref.read(notesProvider.notifier).fetchNotes();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.notes.length,
        itemBuilder: (context, index) {
          final note = state.notes[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Updatenote(note: note),
                  ),
                );
              },
              child: NoteCard(
                title: note.title,
                content: note.content,
                onDelete: () async {
                  final noteState = ref.read(notesProvider.notifier);
                  await noteState.deleteNote(note.id);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Note deleted"),
                        backgroundColor: AppColors.text,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
