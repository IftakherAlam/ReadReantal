import 'package:bookrental/api_service.dart';
import 'package:bookrental/models/book.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Book>> futureBooks;

  @override
  void initState() {
    super.initState();
    futureBooks = ApiService.fetchBooks(); // Fetch books from the backend
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Renting App')),
      body: FutureBuilder<List<Book>>(
        future: futureBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No books available'));
          }

          List<Book> books = snapshot.data!;

          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(books[index].title),
                subtitle: Text(books[index].author),
                onTap: () {
                  // Navigate to book details
                  Navigator.pushNamed(context, '/bookDetails', arguments: books[index].id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
