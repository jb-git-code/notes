import 'package:flutter/material.dart';

class NoteCategoryDef {
  final String id;
  final String label;
  final IconData icon;
  final Color color;

  const NoteCategoryDef({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
  });
}

class NoteCategories {
  NoteCategories._();

  static const uncategorized = 'uncategorized';

  static final List<NoteCategoryDef> all = [
    const NoteCategoryDef(
      id: 'personal',
      label: 'Personal',
      icon: Icons.person_outline_rounded,
      color: Color.fromARGB(255, 134, 50, 213),
    ),
    const NoteCategoryDef(
      id: 'work',
      label: 'Work',
      icon: Icons.work_outline_rounded,
      color: Color(0xFF4F8EDC),
    ),
    const NoteCategoryDef(
      id: 'ideas',
      label: 'Ideas',
      icon: Icons.lightbulb_outline_rounded,
      color: Color(0xFFEBA946),
    ),
    const NoteCategoryDef(
      id: 'tasks',
      label: 'Tasks',
      icon: Icons.check_circle_outline_rounded,
      color: Color(0xFF6FAE8C),
    ),
    const NoteCategoryDef(
      id: 'journal',
      label: 'Journal',
      icon: Icons.menu_book_outlined,
      color: Color(0xFFE76F51),
    ),
  ];

  static NoteCategoryDef byId(String id) {
    return all.firstWhere((c) => c.id == id, orElse: () => all.first);
  }
}
