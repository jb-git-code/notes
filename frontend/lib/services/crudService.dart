import 'dart:convert';
import 'package:http/http.dart' as http;

class Crudservice {
  Future<void> deleteNote(String id) async {
    try {
      final url = Uri.parse('https://notes-csk2.onrender.com/notes/$id');
      await http.delete(url);
    } catch (e) {
      print(e);
    }
  }

   Future<void> updateNote(String title , String content , String id) async {
    
    final url = Uri.parse('https://notes-csk2.onrender.com/notes/$id');
    try {
      await http.put(
        url,

        headers: {"Content-Type": "application/json"},

        body: jsonEncode({
          "title":title ,
          "content": content,
        }),
      );
    } catch (e) {
      print(e);
    }
  }
}
