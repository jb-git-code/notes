import 'package:dio/dio.dart';
import 'package:frontend/core/exceptions/apiExceptions.dart';
import 'package:frontend/core/network/apiClient.dart';
import 'package:frontend/features/notes/models/createNoteResponse.dart';
import 'package:frontend/features/notes/models/noteModel.dart';
import 'package:frontend/features/notes/models/noteResponse.dart';

class NotesRepository {
  final Dio _dio = ApiClient.instance.dio;

  Future<List<NoteModel>> getNotes() async {
    try {
      final response = await _dio.get('/notes');

      final notesResponse = NoteResponse.fromJson(response.data);

      return notesResponse.data;
    } on DioException catch (e) {
      throw ApiException(
        e.response?.data['message'] ?? 'Failed to fetch notes.',
      );
    }
  }

  Future<NoteModel> createNote({
    required String title,
    required String content,
  }) async {
    try {
      final response = await _dio.post(
        '/notes',
        data: {'title': title, 'content': content},
      );

      final noteResponse = CreateNoteResponse.fromJson(response.data);

      return noteResponse.data;
    } on DioException catch (e) {
      throw ApiException(
        e.response?.data['message'] ?? 'Failed to create note.',
      );
    }
  }

  Future<NoteModel> updateNote({
    required String id,
    required String title,
    required String content,
  }) async {
    try {
      final response = await _dio.put(
        '/notes/$id',
        data: {'title': title, 'content': content},
      );

      final noteResponse = CreateNoteResponse.fromJson(response.data);

      return noteResponse.data;
    } on DioException catch (e) {
      throw ApiException(
        e.response?.data['message'] ?? 'Failed to update note.',
      );
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await _dio.delete('/notes/$id');
    } on DioException catch (e) {
      throw ApiException(
        e.response?.data['message'] ?? 'Failed to delete note.',
      );
    }
  }

  Future<CreateNoteResponse> getNoteById(String id) async {
    try {
      final response = await _dio.get('/notes/$id');
      final noteResponse = CreateNoteResponse.fromJson(response.data);
      return noteResponse;
    } on DioException catch (e) {
      throw ApiException(
        e.response?.data['message'] ?? 'Failed to delete note.',
      );
    }
  }
}
