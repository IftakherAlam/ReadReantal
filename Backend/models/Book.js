const pool = require('../config/database'); // Import the database pool

// Create a function to fetch books from the database
const getBooks = async () => {
  try {
    const result = await pool.query('SELECT * FROM books');
    return result.rows; // Return the rows (books) from the query
  } catch (err) {
    console.error('Error fetching books:', err.stack);
    throw err;
  }
};

// Create a function to add a new book to the database
const addBook = async (title, author, genre, availability) => {
  try {
    const result = await pool.query(
      'INSERT INTO books (title, author, genre, availability) VALUES ($1, $2, $3, $4) RETURNING *',
      [title, author, genre, availability]
    );
    return result.rows[0]; // Return the inserted book
  } catch (err) {
    console.error('Error adding book:', err.stack);
    throw err;
  }
};

module.exports = { getBooks, addBook };
