const express = require('express');
const router = express.Router();
const Book = require('../models/Book'); // Assuming you have a Book model
const User = require('../models/Users'); // Assuming you have a User model

// Rent a Book
router.post('/rent/:bookId', async (req, res) => {
  const { userId } = req.body; // Assuming userId is sent in the request body
  
  try {
    const book = await Book.findById(req.params.bookId);
    if (!book) return res.status(404).json({ message: 'Book not found' });
    
    if (book.availability === false) {
      return res.status(400).json({ message: 'This book is currently unavailable' });
    }

    // Rent the book: Update book availability
    book.availability = false;
    await book.save();

    // Record this rent action in the user's history (you may create a RentHistory model)
    const user = await User.findById(userId);
    user.rentedBooks.push(book._id);
    await user.save();

    res.status(200).json({ message: 'Book rented successfully', book });
  } catch (error) {
    res.status(500).json({ message: 'Internal Server Error', error });
  }
});
// Search Books
router.get('/search', async (req, res) => {
    const { query } = req.query; // Get search query from query params
  
    try {
      const books = await Book.find({
        $or: [
          { title: { $regex: query, $options: 'i' } }, // Search by title
          { author: { $regex: query, $options: 'i' } }, // Search by author
          { genre: { $regex: query, $options: 'i' } }   // Search by genre
        ]
      });
  
      res.status(200).json(books);
    } catch (error) {
      res.status(500).json({ message: 'Internal Server Error', error });
    }
  });
  

// Return a Book
router.post('/return/:bookId', async (req, res) => {
  const { userId } = req.body; // Assuming userId is sent in the request body

  try {
    const book = await Book.findById(req.params.bookId);
    if (!book) return res.status(404).json({ message: 'Book not found' });

    // Return the book: Update book availability
    book.availability = true;
    await book.save();

    // Remove the book from user's rentedBooks list
    const user = await User.findById(userId);
    user.rentedBooks = user.rentedBooks.filter(bookId => bookId.toString() !== book._id.toString());
    await user.save();

    res.status(200).json({ message: 'Book returned successfully', book });
  } catch (error) {
    res.status(500).json({ message: 'Internal Server Error', error });
  }
});

module.exports = router;
