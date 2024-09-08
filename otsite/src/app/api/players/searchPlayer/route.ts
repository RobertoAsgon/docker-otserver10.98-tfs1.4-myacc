import { NextRequest } from "next/server";
import { findPlayersByName } from "./service";
import { searchPlayerZodValidator } from "./validator";
import { z } from 'zod';
import { apiResponse } from "@/lib/utils";

export async function GET(req: NextRequest) {
  try {
    const queryParams = searchPlayerZodValidator.parse({
      name: req.nextUrl.searchParams.get("name"),
    });

    const { name } = queryParams;
    const players = await findPlayersByName(name);

    if (players.length === 0) {
      return new Response(null, { status: 204 });
    }

    return apiResponse(200, { players });

  } catch (err) {
    const errorMessage = err instanceof z.ZodError
      ? err.errors.map(e => e.message).join(", ")
      : "Erro ao processar a solicitação.";

    const statusCode = err instanceof z.ZodError ? 400 : 500;

    return apiResponse(statusCode, { message: errorMessage });
  }
}
