// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createNoteResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateNoteResponse _$CreateNoteResponseFromJson(Map<String, dynamic> json) =>
    _CreateNoteResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: NoteModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateNoteResponseToJson(_CreateNoteResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
