// Backend/config/database.js

const { Pool } = require('pg');

// Create a new pool instance with your database connection details
const pool = new Pool({
  user: 'your_username',        // Replace with your PostgreSQL username
  host: 'localhost',            // Use 'localhost' if running PostgreSQL locally
  database: 'bookrental',       // The name of the database
  password: '2206',    // Replace with your PostgreSQL password
  port: 5432,                   // Default PostgreSQL port
});

// Test the connection
pool.connect((err, client, release) => {
  if (err) {
    console.error('Error connecting to the database:', err);
  } else {
    console.log('Connected to the PostgreSQL database');
    release(); // Release the client
  }
});

// Export the pool to be used in other files
module.exports = pool;
