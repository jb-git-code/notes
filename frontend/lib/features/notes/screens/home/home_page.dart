import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/features/notes/screens/home/createNote.dart';
import 'package:frontend/features/notes/screens/home/updateNote.dart';
import 'package:frontend/core/services/crudService.dart';
import 'package:frontend/core/utils/appColors.dart';
import 'package:frontend/core/utils/appTextStyles.dart';
import 'package:frontend/features/notes/widgets/noteCard.dart';
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
  bool hasError = false;
  // True only while we're waiting out a Render cold start (first load,
  // beyond a couple seconds) — lets the UI show a different message
  // than a normal quick refresh.
  bool isColdStart = false;

  Future<void> getNotes() async {
    setState(() {
      isLoading = true;
      hasError = false;
      isColdStart = false;
    });

    // If this takes more than ~3s, assume it's a Render free-tier cold
    // start waking the server up, and let the UI say so.
    final coldStartTimer = Future.delayed(const Duration(seconds: 3), () {
      if (mounted && isLoading) setState(() => isColdStart = true);
    });

    final url = Uri.parse('https://notes-csk2.onrender.com/notes');
    try {
      final response = await http.get(url).timeout(const Duration(seconds: 45));

      if (response.statusCode != 200) {
        throw Exception('Server returned ${response.statusCode}');
      }

      final body = jsonDecode(response.body);
      if (!mounted) return;
      setState(() {
        notes = List<Map<String, dynamic>>.from(body["data"]);
        filterNotes = notes;
        isLoading = false;
        isColdStart = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        isColdStart = false;
        hasError = true;
      });
    } finally {
      // no-op; coldStartTimer just checks `isLoading` when it fires
      unawaited(coldStartTimer);
    }
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
            icon: const Icon(
              Icons.refresh_rounded,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? _LoadingState(isColdStart: isColdStart)
            : hasError
            ? _ErrorState(onRetry: getNotes)
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

class _LoadingState extends StatelessWidget {
  final bool isColdStart;

  const _LoadingState({required this.isColdStart});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: AppColors.primary),
          if (isColdStart) ...[
            const SizedBox(height: 20),
            Text('Waking up the server...', style: AppTextStyles.bodyMedium),
            const SizedBox(height: 6),
            Text(
              'First load can take up to a minute',
              style: AppTextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorState({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cloud_off_rounded,
              size: 40,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'Couldn\'t load your notes',
              style: AppTextStyles.headingMedium,
            ),
            const SizedBox(height: 6),
            Text(
              'Check your connection and try again',
              style: AppTextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 12,
                ),
              ),
              onPressed: onRetry,
              child: Text('Retry', style: AppTextStyles.buttonText),
            ),
          ],
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
