const express = require('express');
const cors = require('cors'); // To handle CORS issues
const bookRoutes = require('./routes/book'); // Import the book routes
const adminRoutes = require('./routes/admin'); // Import the admin routes

const app = express();
const port = 5000;

// Enable CORS for all routes
app.use(cors());

// Middleware to parse JSON bodies
app.use(express.json());

// Admin Routes
app.use('/api/admin', adminRoutes); // Prefix the routes with /api/admin

// Book Routes
app.use('/api/books', bookRoutes); // Prefix the routes with /api/books

// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
