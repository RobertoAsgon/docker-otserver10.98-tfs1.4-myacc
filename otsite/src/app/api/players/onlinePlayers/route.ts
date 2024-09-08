// src/app/api/players/route.ts

import { findOnlinePlayerIds, findPlayersByIds } from "./service";
import { apiResponse } from "@/lib/utils";

export async function GET() {
  try {
    const onlinePlayerIds = await findOnlinePlayerIds();
    
    const onlinePlayers = await findPlayersByIds(onlinePlayerIds);

    return apiResponse(200, {
      onlineCount: onlinePlayers.length,
      onlinePlayers,
    });

  } catch (err) {
    return apiResponse(500, { message: "Erro ao processar a solicitação." });
  }
}
