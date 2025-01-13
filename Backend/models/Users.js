// models/User.js
const { Pool } = require('pg');
const pool = require('../config/database'); // Adjust according to your path

// Define your User model (for PostgreSQL)
const getUserById = async (userId) => {
  try {
    const result = await pool.query('SELECT * FROM users WHERE id = $1', [userId]);
    return result.rows[0]; // Returning a user object
  } catch (error) {
    throw error;
  }
};

module.exports = { getUserById };
