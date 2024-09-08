import mysql2Pool from "@/lib/mysql2Connection";
import { RowDataPacket } from "mysql2";

export async function findPlayersByAccountId(accountId: number): Promise<RowDataPacket[]> {
    const [rows] = await mysql2Pool.query<RowDataPacket[]>(
        `SELECT * FROM players WHERE account_id = ?`,
        [accountId]
    );

    return rows;
}
