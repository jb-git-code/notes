import 'package:freezed_annotation/freezed_annotation.dart';

import 'noteModel.dart';

part 'createNoteResponse.freezed.dart';
part 'createNoteResponse.g.dart';

@freezed
abstract class CreateNoteResponse with _$CreateNoteResponse {
  const factory CreateNoteResponse({
    required bool success,
    required String message,
    required NoteModel data,
  }) = _CreateNoteResponse;

  factory CreateNoteResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateNoteResponseFromJson(json);
}
