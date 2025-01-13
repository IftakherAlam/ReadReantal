import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List _books = [];

  Future<void> _searchBooks() async {
    String query = _searchController.text;

    if (query.isEmpty) {
      setState(() {
        _books = [];
      });
      return;
    }

    final response = await http.get(
      Uri.parse('http://localhost:5000/api/books/search?query=$query'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _books = json.decode(response.body);
      });
    } else {
      // Handle error
      setState(() {
        _books = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Books'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for books...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _searchBooks(),
            ),
          ),
          Expanded(
            child: _books.isEmpty
                ? Center(child: Text('No books found'))
                : ListView.builder(
                    itemCount: _books.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_books[index]['title']),
                        subtitle: Text(_books[index]['author']),
                        onTap: () {
                          // Navigate to book details screen
                          // You can pass book details to the next screen
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
