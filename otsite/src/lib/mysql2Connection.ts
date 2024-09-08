import mysql from 'mysql2/promise';

const mysql2Pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '1234',
  database: 'otserv',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

export default mysql2Pool;
