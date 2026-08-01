import 'package:flutter/material.dart';
import 'package:frontend/features/constants/appColors.dart';
import 'package:frontend/features/constants/appTextStyles.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onDelete;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;
  final Color? categoryColor;

  const NoteCard({
    super.key,
    required this.title,
    required this.content,
    required this.onDelete,
    this.isFavorite = false,
    this.onFavoriteToggle,
    this.categoryColor,
  });

  factory NoteCard.fromJson(
    Map<String, dynamic> json, {
    required VoidCallback onDelete,
  }) {
    return NoteCard(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      onDelete: onDelete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 14, 8, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.headingSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (onFavoriteToggle != null)
              IconButton(
                icon: Icon(
                  isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                ),
                color: isFavorite ? AppColors.danger : AppColors.textSecondary,
                tooltip: isFavorite ? 'Unfavorite' : 'Favorite',
                onPressed: onFavoriteToggle,
              ),
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              color: AppColors.danger,
              tooltip: 'Delete',
              onPressed: () => _confirmDelete(context),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Move to Trash?', style: AppTextStyles.headingSmall),
        content: Text(
          '"$title" will be moved to Trash.',
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
            onPressed: () {
              Navigator.pop(ctx);
              onDelete();
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(
              'Move',
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
