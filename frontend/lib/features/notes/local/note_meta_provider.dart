import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:frontend/core/local/hive_boxes.dart';
import 'package:frontend/features/notes/local/note_meta.dart';

class NoteMetaNotifier extends StateNotifier<Map<String, NoteMeta>> {
  NoteMetaNotifier() : super({}) {
    _load();
  }

  Box get _box => Hive.box(HiveBoxes.noteMeta);

  void _load() {
    final Map<String, NoteMeta> loaded = {};
    for (final key in _box.keys) {
      final raw = _box.get(key);
      if (raw is Map) {
        loaded[key.toString()] = NoteMeta.fromMap(raw);
      }
    }
    state = loaded;
  }

  NoteMeta metaFor(String noteId) => state[noteId] ?? const NoteMeta();

  Future<void> _save(String noteId, NoteMeta meta) async {
    await _box.put(noteId, meta.toMap());
    state = {...state, noteId: meta};
  }

  Future<void> setCategory(String noteId, String categoryId) async {
    await _save(noteId, metaFor(noteId).copyWith(categoryId: categoryId));
  }

  Future<void> toggleFavorite(String noteId) async {
    final meta = metaFor(noteId);
    await _save(noteId, meta.copyWith(isFavorite: !meta.isFavorite));
  }

  Future<void> moveToTrash(String noteId) async {
    await _save(noteId, metaFor(noteId).copyWith(isTrashed: true));
  }

  Future<void> restoreFromTrash(String noteId) async {
    await _save(noteId, metaFor(noteId).copyWith(isTrashed: false));
  }

  Future<void> clearMeta(String noteId) async {
    await _box.delete(noteId);
    final next = {...state}..remove(noteId);
    state = next;
  }
}

final noteMetaProvider =
    StateNotifierProvider<NoteMetaNotifier, Map<String, NoteMeta>>((ref) {
      return NoteMetaNotifier();
    });
