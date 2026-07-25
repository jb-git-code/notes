import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Createnote extends StatefulWidget {
  Createnote({super.key});

  @override
  State<Createnote> createState() => _CreatenoteState();
}

class _CreatenoteState extends State<Createnote> {
  TextEditingController _title = TextEditingController();

  TextEditingController _message = TextEditingController();

  bool isLoading = false;

  Future<void> createNote() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse('https://notes-csk2.onrender.com/notes');
    try {
      await http.post(
        url,

        headers: {"Content-Type": "application/json"},

        body: jsonEncode({
          "title": _title.text.trim(),
          "content": _message.text,
        }),
      );
      setState(() {
        isLoading = false;
      });
      final snackMssg = SnackBar(content: Text('Note Added'));
      ScaffoldMessenger.of(context).showSnackBar(snackMssg);
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Note'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              TextField(
                controller: _title,
                decoration: InputDecoration(
                  hintText: 'Enter Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _message,
                decoration: InputDecoration(
                  hintText: 'Enter Message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.black),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                ),
                onPressed: createNote,
                child: (isLoading)
                    ? Center(child: CircularProgressIndicator())
                    : Text('Create Note'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
