import 'package:freezed_annotation/freezed_annotation.dart';

part 'noteModel.freezed.dart';
part 'noteModel.g.dart';

@freezed
abstract class NoteModel with _$NoteModel {
  const factory NoteModel({
    @JsonKey(name: '_id') required String id,
    required String title,
    required String content,
    required String owner,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _NoteModel;

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);
}
