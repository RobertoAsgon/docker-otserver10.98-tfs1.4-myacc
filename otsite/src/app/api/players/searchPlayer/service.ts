
import pool from "@/libs/connectionDatabase";
import { RowDataPacket } from "mysql2";

export async function findPlayersByName(name: string): Promise<RowDataPacket[]> {
    const [rows] = await pool.query<RowDataPacket[]>(
        `SELECT * FROM players WHERE name = ?`,
        [name]
    );

    return rows;
}
