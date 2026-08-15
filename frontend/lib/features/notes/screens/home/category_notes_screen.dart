import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/constants/appColors.dart';
import 'package:frontend/features/constants/appTextStyles.dart';
import 'package:frontend/features/notes/local/note_meta.dart';
import 'package:frontend/features/notes/local/note_meta_provider.dart';
import 'package:frontend/features/notes/models/note_category.dart';
import 'package:frontend/features/notes/models/noteModel.dart';
import 'package:frontend/features/notes/providers/notesProvider.dart';
import 'package:frontend/features/notes/providers/notesState.dart';
import 'package:frontend/features/notes/screens/home/createNote.dart';
import 'package:frontend/features/notes/screens/home/updateNote.dart';
import 'package:frontend/features/notes/widgets/noteCard.dart';

class CategoryNotesScreen extends ConsumerWidget {
  final String? categoryId;
  final String title;

  const CategoryNotesScreen({
    super.key,
    required this.categoryId,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesState = ref.watch(notesProvider);
    final metaMap = ref.watch(noteMetaProvider);
    final metaNotifier = ref.read(noteMetaProvider.notifier);

    final notes = notesState.notes.where((n) {
      final meta = metaMap[n.id];
      if (meta?.isTrashed ?? false) return false;
      if (categoryId == null) return true;
      return (meta?.categoryId ?? NoteCategories.uncategorized) == categoryId;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(title, style: AppTextStyles.headingSmall),
      ),
      body: _buildBody(context, ref, notesState, notes, metaMap, metaNotifier),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Createnote(initialCategoryId: categoryId),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    NotesState state,
    List<NoteModel> notes,
    Map<String, NoteMeta> metaMap,
    NoteMetaNotifier metaNotifier,
  ) {
    if (state.isLoading) {
      return Center(child: CircularProgressIndicator(color: AppColors.primary));
    }

    if (state.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: AppColors.danger, size: 40),
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
                  'Retry',
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

    if (notes.isEmpty) {
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
            Text('No notes here yet', style: AppTextStyles.headingSmall),
            const SizedBox(height: 4),
            Text(
              'Tap + to add one to this category',
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
      onRefresh: () => ref.read(notesProvider.notifier).fetchNotes(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          final meta = metaMap[note.id] ?? const NoteMeta();

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Updatenote(note: note)),
              ),
              child: NoteCard(
                title: note.title,
                content: note.content,
                isFavorite: meta.isFavorite,
                categoryColor: NoteCategories.byId(meta.categoryId).color,
                onFavoriteToggle: () => metaNotifier.toggleFavorite(note.id),
                onDelete: () async {
                  await metaNotifier.moveToTrash(note.id);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Moved to Trash'),
                        backgroundColor: AppColors.text,
                        behavior: SnackBarBehavior.floating,
                        action: SnackBarAction(
                          label: 'Undo',
                          textColor: AppColors.accent,
                          onPressed: () =>
                              metaNotifier.restoreFromTrash(note.id),
                        ),
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
