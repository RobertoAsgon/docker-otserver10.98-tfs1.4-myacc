import mysql2Pool from '@/lib/mysql2Connection';
import { RowDataPacket } from 'mysql2/promise';

export async function findOnlinePlayerIds(): Promise<number[]> {
  const [rows] = await mysql2Pool.query<RowDataPacket[]>(
    `SELECT player_id FROM players_online`
  );
  
  return rows.map(row => row.player_id);
}

export async function findPlayersByIds(playerIds: number[]): Promise<RowDataPacket[]> {
  if (playerIds.length === 0) {
    return [];
  }

  const [rows] = await mysql2Pool.query<RowDataPacket[]>(
    `SELECT id, name, level, vocation FROM players WHERE id IN (?)`,
    [playerIds]
  );

  return rows;
}
