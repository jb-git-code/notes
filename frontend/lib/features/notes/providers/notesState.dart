import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/noteModel.dart';

part 'notesState.freezed.dart';

@freezed
abstract class NotesState with _$NotesState {
  const factory NotesState({
    @Default([]) List<NoteModel> notes,
    @Default(false) bool isLoading,
    String? error,
  }) = _NotesState;
}
