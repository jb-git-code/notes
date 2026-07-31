// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noteResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NoteResponse _$NoteResponseFromJson(Map<String, dynamic> json) =>
    _NoteResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NoteResponseToJson(_NoteResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
