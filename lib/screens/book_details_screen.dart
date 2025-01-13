import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookDetailsScreen extends StatefulWidget {
  final String bookId;
  final String title;
  final String author;
  final String genre;
  final bool availability;

  BookDetailsScreen({
    required this.bookId,
    required this.title,
    required this.author,
    required this.genre,
    required this.availability,
  });

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  bool _isRented = false;

  Future<void> _rentBook() async {
    final response = await http.post(
      Uri.parse('http://your-backend-url/api/rent/${widget.bookId}'),
      body: json.encode({'userId': 'userId'}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _isRented = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Book rented successfully')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to rent book')));
    }
  }

  Future<void> _returnBook() async {
    final response = await http.post(
      Uri.parse('http://your-backend-url/api/return/${widget.bookId}'),
      body: json.encode({'userId': 'userId'}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _isRented = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Book returned successfully')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to return book')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(widget.title, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(widget.author, style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
            SizedBox(height: 10),
            Text(widget.genre, style: TextStyle(fontSize: 20)),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _isRented ? _returnBook : _rentBook,
              icon: Icon(_isRented ? Icons.undo : Icons.bookmark),
              label: Text(_isRented ? 'Return Book' : 'Rent Book'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
