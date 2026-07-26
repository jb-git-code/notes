import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/screens/createNote.dart';
import 'package:frontend/screens/updateNote.dart';
import 'package:frontend/services/crudService.dart';
import 'package:frontend/utils/appColors.dart';
import 'package:frontend/utils/appTextStyles.dart';
import 'package:frontend/widgets/noteCard.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> notes = [];
  List<Map<String, dynamic>> filterNotes = [];
  final TextEditingController _query = TextEditingController();
  bool isLoading = false;

  Future<void> getNotes() async {
    setState(() => isLoading = true);
    final url = Uri.parse('https://notes-csk2.onrender.com/notes');
    final response = await http.get(url);
    final body = jsonDecode(response.body);
    setState(() {
      notes = List<Map<String, dynamic>>.from(body["data"]);
      filterNotes = notes;
      isLoading = false;
    });
  }

  void searchNotes(String query) {
    setState(() {
      final q = query.toLowerCase();
      filterNotes = notes.where((note) {
        final title = (note["title"] ?? "").toString().toLowerCase();
        final content = (note["content"] ?? "").toString().toLowerCase();
        return title.contains(q) || content.contains(q);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('My Notes', style: AppTextStyles.headingLarge),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: getNotes,
            icon: const Icon(Icons.refresh_rounded, color: AppColors.textPrimary),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 4),
                    _SearchField(controller: _query, onChanged: searchNotes),
                    const SizedBox(height: 20),
                    Expanded(
                      child: notes.isEmpty
                          ? _EmptyState()
                          : filterNotes.isEmpty
                              ? _NoResultsState()
                              : RefreshIndicator(
                                  color: AppColors.primary,
                                  onRefresh: getNotes,
                                  child: ListView.separated(
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    itemCount: filterNotes.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 12),
                                    itemBuilder: (context, index) {
                                      final noteData = filterNotes[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Updatenote(
                                                id: noteData["_id"],
                                                title: noteData["title"],
                                                content: noteData["content"],
                                              ),
                                            ),
                                          ).then((_) => getNotes());
                                        },
                                        child: NoteCard(
                                          title: noteData["title"],
                                          content: noteData["content"],
                                          onDelete: () {
                                            Crudservice().deleteNote(
                                              noteData["_id"],
                                            );
                                            getNotes();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Createnote()),
          ).then((_) => getNotes());
        },
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        icon: const Icon(Icons.add_rounded),
        label: Text('New note', style: AppTextStyles.buttonText),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchField({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: AppTextStyles.bodyMedium,
      decoration: InputDecoration(
        hintText: 'Search notes',
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.textSecondary,
        ),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.note_add_outlined,
              size: 40,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          Text('No notes yet', style: AppTextStyles.headingMedium),
          const SizedBox(height: 6),
          Text(
            'Tap "New note" to add your first one',
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _NoResultsState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 36,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 12),
          Text('No matching notes', style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}