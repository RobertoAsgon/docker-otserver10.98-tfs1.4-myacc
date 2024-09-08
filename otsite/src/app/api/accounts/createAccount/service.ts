import { ResultSetHeader, RowDataPacket } from 'mysql2/promise';
import mysql2Pool from '@/lib/mysql2Connection';
import { getSha1Hash } from '@/lib/utils';

export async function createAccount(name: string, password: string, email: string) {
  const [existingAccount] = await mysql2Pool.query<RowDataPacket[]>(
    `SELECT id FROM accounts WHERE name = ? LIMIT 1`,
    [name]
  );

  console.log("existingAccount", existingAccount)

  if (existingAccount.length > 0) {
    return { success: false, message: "Já existe uma conta com este nome." };
  }

  const hashedPassword = getSha1Hash(password);
  const created = Math.floor(Date.now() / 1000);

  const [result] = await mysql2Pool.query<ResultSetHeader>(
    `
      INSERT INTO accounts (name, password, email, created, type, premdays) 
      VALUES (?, ?, ?, ?, 0, 7)
    `,
    [name, hashedPassword, email, created]
  );

  console.log('result', result)
  
  return result.affectedRows > 0
    ? { success: true }
    : { success: false, message: "Houve um problema ao criar a conta." };
}
