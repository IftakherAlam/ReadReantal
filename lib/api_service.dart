import 'dart:convert';
import 'package:bookrental/models/book.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api'; // Replace with your backend URL

  // Fetch all books
  static Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/books'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((book) => Book.fromJson(book)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  // Fetch a specific book by ID
  static Future<Book> fetchBookDetails(String bookId) async {
    final response = await http.get(Uri.parse('$baseUrl/books/$bookId'));

    if (response.statusCode == 200) {
      return Book.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load book details');
    }
  }

  // Add a new book
  static Future<void> addBook(Book book) async {
    final response = await http.post(
      Uri.parse('$baseUrl/books'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(book.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add book');
    }
  }

  // Update an existing book
  static Future<void> updateBook(String bookId, Book book) async {
    final response = await http.put(
      Uri.parse('$baseUrl/books/$bookId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(book.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update book');
    }
  }

  // Delete a book
  static Future<void> deleteBook(String bookId) async {
    final response = await http.delete(Uri.parse('$baseUrl/books/$bookId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete book');
    }
  }
}
