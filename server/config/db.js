const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: 'localhost',
  port: 3306,
  user: 'root',
  password: '',  // Keep empty if no password is set
  database: 'senior_project',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  connectTimeout: 60 * 60 * 1000,  // 1 hour in milliseconds
  acquireTimeout: 60 * 60 * 1000,
  timeout: 60 * 60 * 1000
});

module.exports = pool;
