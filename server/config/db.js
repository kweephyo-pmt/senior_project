const mysql = require('mysql2/promise');

// Cloud SQL configuration with environment variables
const dbConfig = {
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'senior_project',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  connectTimeout: 60000,  // 60 seconds
  acquireTimeout: 60000,
  timeout: 60000
};

// Check if we're using Cloud SQL Unix socket or TCP connection
if (process.env.DB_HOST && process.env.DB_HOST.startsWith('/cloudsql/')) {
  // Unix socket connection for Cloud SQL
  dbConfig.socketPath = process.env.DB_HOST;
} else {
  // TCP connection for local development or direct IP
  dbConfig.host = process.env.DB_HOST || 'localhost';
  dbConfig.port = process.env.DB_PORT || 3306;
  if (process.env.NODE_ENV === 'production') {
    dbConfig.ssl = { rejectUnauthorized: false };
  }
}

const pool = mysql.createPool(dbConfig);

module.exports = pool;
