import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/constants/appColors.dart';
import 'package:frontend/features/constants/appTextStyles.dart';
import 'package:frontend/features/notes/local/note_meta_provider.dart';
import 'package:frontend/features/notes/models/note_category.dart';
import 'package:frontend/features/notes/providers/notesProvider.dart';
import 'package:frontend/features/notes/screens/home/category_notes_screen.dart';
import 'package:frontend/features/notes/screens/home/createNote.dart';

class NotesCategoryGridScreen extends ConsumerWidget {
  const NotesCategoryGridScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesState = ref.watch(notesProvider);
    final metaMap = ref.watch(noteMetaProvider);

    int countFor(String? categoryId) {
      return notesState.notes.where((n) {
        final meta = metaMap[n.id];
        if (meta?.isTrashed ?? false) return false;
        if (categoryId == null) return true;
        return (meta?.categoryId ?? NoteCategories.uncategorized) == categoryId;
      }).length;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('My Notes', style: AppTextStyles.headingSmall),
      ),
      body: notesState.isLoading
          ? Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.15,
              children: [
                _CategoryTile(
                  label: 'All Notes',
                  icon: Icons.grid_view_rounded,
                  color: AppColors.primary,
                  count: countFor(null),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CategoryNotesScreen(
                        categoryId: null,
                        title: 'All Notes',
                      ),
                    ),
                  ),
                ),
                for (final cat in NoteCategories.all)
                  _CategoryTile(
                    label: cat.label,
                    icon: cat.icon,
                    color: cat.color,
                    count: countFor(cat.id),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryNotesScreen(
                          categoryId: cat.id,
                          title: cat.label,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Createnote()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final int count;
  final VoidCallback onTap;

  const _CategoryTile({
    required this.label,
    required this.icon,
    required this.color,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(AppColors.isDark ? 0.22 : 0.14),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '$count note${count == 1 ? '' : 's'}',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}