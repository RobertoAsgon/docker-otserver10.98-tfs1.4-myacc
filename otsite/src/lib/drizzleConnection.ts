import { drizzle } from 'drizzle-orm/mysql2';
import mysql from 'mysql2/promise';

async function getDrizzlePool() {
  const poolConnection = await mysql.createPool({
    host: 'db',
    user: 'root',
    password: '1234',
    database: 'otserv',
  });

  return drizzle(poolConnection);
}

export const drizlePool = getDrizzlePool()