import 'package:flutter/material.dart';
import 'package:frontend/services/crudService.dart';


class Updatenote extends StatefulWidget {
  const Updatenote({super.key, required this.id});
  final String id;

  @override
  State<Updatenote> createState() => _UpdatenoteState();
}

class _UpdatenoteState extends State<Updatenote> {
  TextEditingController _title = TextEditingController();

  TextEditingController _message = TextEditingController();

  bool isLoading = false;

  Future<void> updateCurrentNote() async {
    setState(() {
      isLoading = true;
    });
    try {
      Crudservice().updateNote(_title.text.trim(), _message.text, widget.id);
      setState(() {
        isLoading = false;
      });
      final snackMssg = SnackBar(content: Text('Note Updated'));
      ScaffoldMessenger.of(context).showSnackBar(snackMssg);
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Note'), centerTitle: true),
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
                onPressed: updateCurrentNote,
                child: (isLoading)
                    ? Center(child: CircularProgressIndicator())
                    : Text('Update Note'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
