const express = require('express');
const cors = require('cors');
const pool = require('./config/db');

const app = express();

// Middleware
app.use(cors({
  origin: 'http://localhost:3000', // Your Nuxt frontend URL
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));
app.use(express.json());

// Routes
// Health check endpoint
app.get('/api/health', async (req, res) => {
  try {
    // Test database connection
    const [result] = await pool.query('SELECT 1 + 1 AS result');
    res.json({
      status: 'ok',
      database: 'connected',
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Database connection error:', error);
    res.status(500).json({
      status: 'error',
      database: 'disconnected',
      error: error.message
    });
  }
});

// Teaching performance endpoint
app.get('/api/teaching-performance', async (req, res) => {
  try {
    // Fetch undergraduate data
    const [undergradRows] = await pool.query(
      'SELECT course_code, course_name, total_student FROM undergraduate'
    );

    const undergraduateData = undergradRows.map((item, index) => ({
      id: index + 1,
      course_code: item.course_code,
      course_name: item.course_name,
      total_student: item.total_student
    }));

    // Fetch graduate data
    const [gradRows] = await pool.query(
      'SELECT course_code, course_name, total_student FROM graduate'
    );

    const graduateData = gradRows.map((item, index) => ({
      id: index + 1,
      course_code: item.course_code,
      course_name: item.course_name,
      total_student: item.total_student
    }));

    res.json({
      undergraduate: undergraduateData,
      graduate: graduateData
    });
  } catch (error) {
    console.error('Error fetching teaching data:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Something went wrong!' });
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
