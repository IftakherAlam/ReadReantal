const express = require('express');
const router = express.Router();
const Book = require('../models/Book');

// Add a Book (Admin)
router.post('/add', async (req, res) => {
  const { title, author, genre, availability } = req.body;

  try {
    const newBook = new Book({ title, author, genre, availability });
    await newBook.save();

    res.status(201).json({ message: 'Book added successfully', book: newBook });
  } catch (error) {
    res.status(500).json({ message: 'Internal Server Error', error });
  }
});

// Edit a Book (Admin)
router.put('/edit/:bookId', async (req, res) => {
  const { title, author, genre, availability } = req.body;

  try {
    const book = await Book.findById(req.params.bookId);
    if (!book) return res.status(404).json({ message: 'Book not found' });

    book.title = title || book.title;
    book.author = author || book.author;
    book.genre = genre || book.genre;
    book.availability = availability !== undefined ? availability : book.availability;
    
    await book.save();

    res.status(200).json({ message: 'Book updated successfully', book });
  } catch (error) {
    res.status(500).json({ message: 'Internal Server Error', error });
  }
});

// Delete a Book (Admin)
router.delete('/delete/:bookId', async (req, res) => {
  try {
    const book = await Book.findByIdAndDelete(req.params.bookId);
    if (!book) return res.status(404).json({ message: 'Book not found' });

    res.status(200).json({ message: 'Book deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Internal Server Error', error });
  }
});

module.exports = router;
