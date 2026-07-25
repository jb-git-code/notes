import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/screens/createNote.dart';
import 'package:frontend/widgets/noteCard.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> notes = [];

  Future<void> getNotes() async {
    final url = Uri.parse('https://notes-csk2.onrender.com/notes');
    final response = await http.get(url);
    final body = jsonDecode(response.body);
    setState(() {
      notes = List<Map<String, dynamic>>.from(body["data"]);
    });
  }

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes App'),
        centerTitle: true,
        actions: [IconButton(onPressed: getNotes, icon: Icon(Icons.refresh))],
      ),
      body: (notes.length == 0)
          ? Center(child: Text('Add your first note'))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final noteData = notes[index];
                return NoteCard(
                  title: noteData["title"],
                  content: noteData["content"],
                  onDelete: () {},
                );
              },
            ),
      floatingActionButton: TextButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Createnote()),
          );
        },
        icon: Icon(Icons.add),
        label: Text('Add'),
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          backgroundColor: WidgetStatePropertyAll(Colors.black),
        ),
      ),
    );
  }
}
