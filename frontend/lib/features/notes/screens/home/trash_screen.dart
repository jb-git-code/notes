import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/constants/appColors.dart';
import 'package:frontend/features/constants/appTextStyles.dart';
import 'package:frontend/features/notes/local/note_meta_provider.dart';
import 'package:frontend/features/notes/providers/notesProvider.dart';

class TrashScreen extends ConsumerWidget {
  const TrashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesState = ref.watch(notesProvider);
    final metaMap = ref.watch(noteMetaProvider);
    final metaNotifier = ref.read(noteMetaProvider.notifier);

    final trashedNotes = notesState.notes
        .where((n) => metaMap[n.id]?.isTrashed ?? false)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Trash', style: AppTextStyles.headingSmall),
      ),
      body: trashedNotes.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.delete_outline_rounded,
                    size: 64,
                    color: AppColors.accent.withOpacity(0.6),
                  ),
                  const SizedBox(height: 16),
                  Text('Trash is empty', style: AppTextStyles.headingSmall),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: trashedNotes.length,
              itemBuilder: (context, index) {
                final note = trashedNotes[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.divider),
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                note.title,
                                style: AppTextStyles.headingSmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                note.content,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.restore_rounded),
                              color: AppColors.primary,
                              tooltip: 'Restore',
                              onPressed: () =>
                                  metaNotifier.restoreFromTrash(note.id),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_forever_rounded),
                              color: AppColors.danger,
                              tooltip: 'Delete forever',
                              onPressed: () => _confirmPermanentDelete(
                                context,
                                ref,
                                note.id,
                                note.title,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _confirmPermanentDelete(
    BuildContext context,
    WidgetRef ref,
    String noteId,
    String title,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Delete permanently?', style: AppTextStyles.headingSmall),
        content: Text(
          '"$title" will be permanently deleted. This cannot be undone.',
          style: AppTextStyles.bodyMedium,
        ),
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
              Navigator.pop(ctx);
              await ref.read(notesProvider.notifier).deleteNote(noteId);
              await ref.read(noteMetaProvider.notifier).clearMeta(noteId);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(
              'Delete',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.danger,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
