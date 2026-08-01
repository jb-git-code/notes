import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/constants/appColors.dart';
import 'package:frontend/features/constants/appTextStyles.dart';
import 'package:frontend/features/notes/local/note_meta_provider.dart';
import 'package:frontend/features/notes/models/noteModel.dart';
import 'package:frontend/features/notes/models/note_category.dart';
import 'package:frontend/features/notes/providers/notesProvider.dart';
import 'package:frontend/features/notes/widgets/category_chip.dart';

class Updatenote extends ConsumerStatefulWidget {
  const Updatenote({super.key, required this.note});
  final NoteModel note;

  @override
  ConsumerState<Updatenote> createState() => _UpdatenoteState();
}

class _UpdatenoteState extends ConsumerState<Updatenote> {
  late final TextEditingController _title;
  late final TextEditingController _message;
  late String _selectedCategoryId;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.note.title);
    _message = TextEditingController(text: widget.note.content);
    final meta = ref.read(noteMetaProvider)[widget.note.id];
    _selectedCategoryId = meta?.categoryId ?? NoteCategories.uncategorized;
  }

  Future<void> updateCurrentNote() async {
    if (_title.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Title cannot be empty')));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final noteState = ref.read(notesProvider.notifier);
      await noteState.updateNote(
        id: widget.note.id,
        title: _title.text.trim(),
        content: _message.text,
      );
      await ref
          .read(noteMetaProvider.notifier)
          .setCategory(widget.note.id, _selectedCategoryId);

      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Note updated')));
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not update note, try again')),
      );
    }
  }

  Future<void> _moveToTrash() async {
    await ref.read(noteMetaProvider.notifier).moveToTrash(widget.note.id);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Moved to Trash')));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _title.dispose();
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final meta = ref.watch(noteMetaProvider)[widget.note.id];
    final isFavorite = meta?.isFavorite ?? false;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        title: Text('Edit note', style: AppTextStyles.headingLarge),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            ),
            color: isFavorite ? AppColors.danger : AppColors.textSecondary,
            tooltip: isFavorite ? 'Unfavorite' : 'Favorite',
            onPressed: () =>
                ref.read(noteMetaProvider.notifier).toggleFavorite(widget.note.id),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            color: AppColors.danger,
            tooltip: 'Move to Trash',
            onPressed: _moveToTrash,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _title,
                style: AppTextStyles.headingSmall,
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: AppTextStyles.headingSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  filled: true,
                  fillColor: AppColors.surface,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryChip(
                      label: 'None',
                      color: AppColors.textSecondary,
                      selected: _selectedCategoryId == NoteCategories.uncategorized,
                      onTap: () => setState(
                        () => _selectedCategoryId = NoteCategories.uncategorized,
                      ),
                    ),
                    for (final cat in NoteCategories.all)
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: CategoryChip(
                          label: cat.label,
                          color: cat.color,
                          selected: _selectedCategoryId == cat.id,
                          onTap: () => setState(() => _selectedCategoryId = cat.id),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TextField(
                  controller: _message,
                  style: AppTextStyles.bodyLarge,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: 'Write your note...',
                    hintStyle: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    filled: true,
                    fillColor: AppColors.surface,
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: isLoading ? null : updateCurrentNote,
                  child: isLoading
                      ? SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: AppColors.textOnPrimary,
                            strokeWidth: 2.4,
                          ),
                        )
                      : Text('Update note', style: AppTextStyles.buttonText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}