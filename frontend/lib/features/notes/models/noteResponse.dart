import 'package:freezed_annotation/freezed_annotation.dart';

import 'noteModel.dart';

part 'noteResponse.freezed.dart';
part 'noteResponse.g.dart';

@freezed
abstract class NoteResponse with _$NoteResponse {
  const factory NoteResponse({
    required bool success,
    required String message,
    required List<NoteModel> data,
  }) = _NoteResponse;

  factory NoteResponse.fromJson(Map<String, dynamic> json) =>
      _$NoteResponseFromJson(json);
}