import { RowDataPacket } from 'mysql2/promise';
import jwt from 'jsonwebtoken';
import mysql2Pool from '@/lib/mysql2Connection';
import { getSha1Hash } from '@/lib/utils';
import { JWT_SECRET } from '@/lib/jwt';

interface AuthResult {
  token: string;
  loggedUser: {
    id: number;
    name: string;
    email: string;
  };
}

export async function authenticateUser(name: string, password: string): Promise<AuthResult | null> {
  const hashedPassword = getSha1Hash(password);

  const [rows] = await mysql2Pool.query<RowDataPacket[]>(
    `SELECT * FROM accounts WHERE name = ? LIMIT 1`,
    [name]
  );

  if (rows.length === 0 || rows[0].password !== hashedPassword) {
    return null;
  }

  const loggedUser = rows[0];

  const token = jwt.sign(
    {
      accountId: loggedUser.id,
      accountName: loggedUser.name,
      email: loggedUser.email,
    },
    JWT_SECRET,
    {
      expiresIn: '8h',
    }
  );

  return {
    token,
    loggedUser: {
      id: loggedUser.id,
      name: loggedUser.name,
      email: loggedUser.email,
    },
  };
}
