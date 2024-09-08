import mysql2Pool from '@/lib/mysql2Connection';
import { RowDataPacket, ResultSetHeader } from 'mysql2/promise';

export const samplesVocation: { [vocation: number]: string } = {
    1: "Naruto Sample",
    2: "Sasuke Sample",
    3: "Sakura Sample",
    4: "Rock Lee Sample",
    5: "Neji Sample",
    6: "Tenten Sample",
    7: "Kiba Sample",
    8: "Hinata Sample",
    9: "Shino Sample",
    10: "Shikamaru Sample",
    11: "Ino Sample",
    12: "Chouji Sample",
};

export async function findSampleByName(name: string): Promise<RowDataPacket | null> {
    const [rows] = await mysql2Pool.query<RowDataPacket[]>(
        `SELECT * FROM players WHERE name = ? LIMIT 1`,
        [name]
    );

    if (rows.length === 0) {
        return null;
    }

    return rows[0];
}

export async function createPlayer(sample: RowDataPacket, name: string, accountId: number): Promise<boolean> {
    const created = Math.floor(Date.now() / 1000);

    const [result] = await mysql2Pool.query<ResultSetHeader>(
        `
        INSERT INTO players (
            name, group_id, account_id, level, vocation, health, healthmax, 
            experience, lookbody, lookfeet, lookhead, looklegs, looktype, lookaddons, 
            direction, maglevel, mana, manamax, manaspent, soul, town_id, posx, posy, posz, 
            conditions, cap, sex, lastlogin, lastip, save, skull, skulltime, lastlogout, 
            blessings, onlinetime, deletion, balance, offlinetraining_time, offlinetraining_skill, 
            stamina, skill_fist, skill_fist_tries, skill_club, skill_club_tries, skill_sword, 
            skill_sword_tries, skill_axe, skill_axe_tries, skill_dist, skill_dist_tries, 
            skill_shielding, skill_shielding_tries, skill_fishing, skill_fishing_tries, 
            created, hidden, comment
        ) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `,
        [
            name, sample.group_id, accountId, sample.level, sample.vocation, sample.health, sample.healthmax, 
            sample.experience, sample.lookbody, sample.lookfeet, sample.lookhead, sample.looklegs, sample.looktype, sample.lookaddons, 
            sample.direction, sample.maglevel, sample.mana, sample.manamax, sample.manaspent, sample.soul, sample.town_id, sample.posx, 
            sample.posy, sample.posz, sample.conditions, sample.cap, sample.sex, sample.lastlogin, sample.lastip, sample.save, sample.skull, 
            sample.skulltime, sample.lastlogout, sample.blessings, sample.onlinetime, sample.deletion, sample.balance, sample.offlinetraining_time, 
            sample.offlinetraining_skill, sample.stamina, sample.skill_fist, sample.skill_fist_tries, sample.skill_club, sample.skill_club_tries, 
            sample.skill_sword, sample.skill_sword_tries, sample.skill_axe, sample.skill_axe_tries, sample.skill_dist, sample.skill_dist_tries, 
            sample.skill_shielding, sample.skill_shielding_tries, sample.skill_fishing, sample.skill_fishing_tries, created, sample.hidden, sample.comment
        ]
    );

    return result.affectedRows > 0;
}

export async function playerExists(name: string): Promise<boolean> {
    const [rows] = await mysql2Pool.query<RowDataPacket[]>(
        `SELECT id FROM players WHERE name = ? LIMIT 1`,
        [name]
    );

    return rows.length > 0;
}