import { NextRequest } from "next/server";

import { createPlayerZodValidator } from "./validator";
import { createPlayer, findSampleByName, samplesVocation, playerExists } from "./service";
import { z } from 'zod';
import { apiResponse } from "@/lib/utils";
import { checkAuthMiddleware, privateRoute } from "@/lib/jwt";

export async function POST(req: NextRequest) {
  return privateRoute(req, async (req) => {
    try {
      const body = await req.json();
      const { name, vocation } = createPlayerZodValidator.parse(body);
      const { user } = checkAuthMiddleware(req);

      if (!user?.accountId) {
        return apiResponse(400, { message: "Você deve estar logado para criar um novo personagem." });
      }

      const playerAlreadyExists = await playerExists(name);
      if (playerAlreadyExists) {
        return apiResponse(409, { message: "Já existe um personagem com esse nome." });
      }

      const sampleName = samplesVocation[vocation];
      const sample = await findSampleByName(sampleName);

      if (!sample) {
        return apiResponse(404, { message: "Vocação selecionada não encontrada." });
      }

      const playerCreated = await createPlayer(sample, name, user?.accountId);

      return playerCreated
        ? apiResponse(201, { message: "Personagem criado com sucesso!" })
        : apiResponse(500, { message: "Erro ao criar novo personagem." });

    } catch (err) {
      console.log("err", err)
      if (err instanceof z.ZodError) {
        return apiResponse(400, { message: err.errors.map(e => e.message).join(", ") });
      }
      return apiResponse(500, { message: "Erro ao processar a solicitação." });
    }
  });
}
