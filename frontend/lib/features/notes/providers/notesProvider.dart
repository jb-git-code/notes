import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/notes/providers/notesNotifier.dart';
import 'package:frontend/features/notes/providers/notesState.dart';

import '../repositories/noteRepository.dart';

final notesRepositoryProvider = Provider<NotesRepository>((ref) {
  return NotesRepository();
});

final notesProvider = NotifierProvider<NotesNotifier, NotesState>(
  NotesNotifier.new,
);
