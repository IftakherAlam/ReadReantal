import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditBookScreen extends StatefulWidget {
  final String bookId;
  final String title;
  final String author;
  final String genre;
  final bool availability;

  EditBookScreen({
    required this.bookId,
    required this.title,
    required this.author,
    required this.genre,
    required this.availability,
  });

  @override
  _EditBookScreenState createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _genreController;
  late bool _availability;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _authorController = TextEditingController(text: widget.author);
    _genreController = TextEditingController(text: widget.genre);
    _availability = widget.availability;
  }

  Future<void> _editBook() async {
    final response = await http.put(
      Uri.parse('http://your-backend-url/api/admin/edit/${widget.bookId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': _titleController.text,
        'author': _authorController.text,
        'genre': _genreController.text,
        'availability': _availability,
      }),
    );

    if (response.statusCode == 200) {
      // Book updated successfully
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Book updated successfully'),
      ));
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update book'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Author'),
            ),
            TextField(
              controller: _genreController,
              decoration: InputDecoration(labelText: 'Genre'),
            ),
            SwitchListTile(
              title: Text('Available'),
              value: _availability,
              onChanged: (value) {
                setState(() {
                  _availability = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _editBook,
              child: Text('Update Book'),
            ),
          ],
        ),
      ),
    );
  }
}
