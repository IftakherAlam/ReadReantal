import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddBookScreen extends StatefulWidget {
  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  bool _availability = true;

  Future<void> _addBook() async {
    final response = await http.post(
      Uri.parse('http://your-backend-url/api/admin/add'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': _titleController.text,
        'author': _authorController.text,
        'genre': _genreController.text,
        'availability': _availability,
      }),
    );

    if (response.statusCode == 201) {
      // Book added successfully
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Book added successfully'),
      ));
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add book'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
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
              onPressed: _addBook,
              child: Text('Add Book'),
            ),
          ],
        ),
      ),
    );
  }
}
