
import mysql2Pool from "@/lib/mysql2Connection";
import { RowDataPacket } from "mysql2";

export async function findPlayersByName(name: string): Promise<RowDataPacket[]> {
    const [rows] = await mysql2Pool.query<RowDataPacket[]>(
        `SELECT * FROM players WHERE name = ?`,
        [name]
    );

    return rows;
}
