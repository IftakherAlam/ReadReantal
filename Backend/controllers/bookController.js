const Book = require('../models/Book');

exports.getBooks = async (req, res) => {
  const books = await Book.findAll();
  res.json(books);
};

exports.addBook = async (req, res) => {
  const { title, author, genre } = req.body;
  const newBook = await Book.create({ title, author, genre });
  res.status(201).json(newBook);
};
