class NoteMeta {
  final String categoryId;
  final bool isFavorite;
  final bool isTrashed;

  const NoteMeta({
    this.categoryId = 'uncategorized',
    this.isFavorite = false,
    this.isTrashed = false,
  });

  NoteMeta copyWith({String? categoryId, bool? isFavorite, bool? isTrashed}) {
    return NoteMeta(
      categoryId: categoryId ?? this.categoryId,
      isFavorite: isFavorite ?? this.isFavorite,
      isTrashed: isTrashed ?? this.isTrashed,
    );
  }

  Map<String, dynamic> toMap() => {
    'categoryId': categoryId,
    'isFavorite': isFavorite,
    'isTrashed': isTrashed,
  };

  factory NoteMeta.fromMap(Map map) => NoteMeta(
    categoryId: map['categoryId'] as String? ?? 'uncategorized',
    isFavorite: map['isFavorite'] as bool? ?? false,
    isTrashed: map['isTrashed'] as bool? ?? false,
  );
}