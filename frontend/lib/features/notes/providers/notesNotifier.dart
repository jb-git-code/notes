import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/exceptions/apiExceptions.dart';
import 'package:frontend/features/notes/providers/notesProvider.dart';
import 'package:frontend/features/notes/providers/notesState.dart';


class NotesNotifier extends Notifier<NotesState> {
  @override
  NotesState build() {
    return const NotesState();
  }

  Future<void> fetchNotes() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final notes = await ref.read(notesRepositoryProvider).getNotes();

      state = state.copyWith(isLoading: false, notes: notes);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    }
  }

  Future<void> addNote({required String title, required String content}) async {
    try {
      final newNote = await ref
          .read(notesRepositoryProvider)
          .createNote(title: title, content: content);

      state = state.copyWith(notes: [...state.notes, newNote]);
    } on ApiException catch (e) {
      state = state.copyWith(error: e.message);
    }
  }

  Future<void> updateNote({
    required String id,
    required String title,
    required String content,
  }) async {
    try {
      final updatedNote = await ref
          .read(notesRepositoryProvider)
          .updateNote(id: id, title: title, content: content);

      final updatedNotes = state.notes.map((note) {
        return note.id == id ? updatedNote : note;
      }).toList();

      state = state.copyWith(notes: updatedNotes);
    } on ApiException catch (e) {
      state = state.copyWith(error: e.message);
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await ref.read(notesRepositoryProvider).deleteNote(id);

      state = state.copyWith(
        notes: state.notes.where((note) => note.id != id).toList(),
      );
    } on ApiException catch (e) {
      state = state.copyWith(error: e.message);
    }
  }
}