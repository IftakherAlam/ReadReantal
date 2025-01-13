import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List books = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/books'));
    if (response.statusCode == 200) {
      setState(() {
        books = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Books")),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(books[index]['title']),
            subtitle: Text(books[index]['author']),
          );
        },
      ),
    );
  }
}
