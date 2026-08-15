import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/constants/appColors.dart';
import 'package:frontend/features/constants/appTextStyles.dart';
import 'package:frontend/features/notes/local/note_meta.dart';
import 'package:frontend/features/notes/local/note_meta_provider.dart';
import 'package:frontend/features/notes/models/note_category.dart';
import 'package:frontend/features/notes/providers/notesProvider.dart';
import 'package:frontend/features/notes/screens/home/updateNote.dart';
import 'package:frontend/features/notes/widgets/noteCard.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesState = ref.watch(notesProvider);
    final metaMap = ref.watch(noteMetaProvider);
    final metaNotifier = ref.read(noteMetaProvider.notifier);

    final favNotes = notesState.notes.where((n) {
      final meta = metaMap[n.id];
      return (meta?.isFavorite ?? false) && !(meta?.isTrashed ?? false);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Favorites', style: AppTextStyles.headingSmall),
      ),
      body: favNotes.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite_border_rounded,
                    size: 64,
                    color: AppColors.accent.withOpacity(0.6),
                  ),
                  const SizedBox(height: 16),
                  Text('No favorites yet', style: AppTextStyles.headingSmall),
                  const SizedBox(height: 4),
                  Text(
                    'Tap the heart on a note to pin it here',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favNotes.length,
              itemBuilder: (context, index) {
                final note = favNotes[index];
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
                      isFavorite: true,
                      categoryColor: NoteCategories.byId(meta.categoryId).color,
                      onFavoriteToggle: () =>
                          metaNotifier.toggleFavorite(note.id),
                      onDelete: () async {
                        await metaNotifier.moveToTrash(note.id);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Moved to Trash'),
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
