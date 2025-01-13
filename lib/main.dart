import 'package:flutter/material.dart';
import 'screens/home_screen.dart';  // Correct import for home_screen.dart
import 'screens/search_screen.dart';  // Correct import for search_screen.dart
import 'screens/book_details_screen.dart';  // Correct import for book_details_screen.dart
import 'screens/add_book_screen.dart';  // Correct import for add_book_screen.dart
import 'screens/edit_book_screen.dart';  // Correct import for edit_book_screen.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Renting App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/search': (context) => SearchScreen(),
        '/addBook': (context) => AddBookScreen(),
        // '/editBook': (context) => EditBookScreen(),
        // '/bookDetails': (context) => BookDetailsScreen(),
      },
    );
  }
}
