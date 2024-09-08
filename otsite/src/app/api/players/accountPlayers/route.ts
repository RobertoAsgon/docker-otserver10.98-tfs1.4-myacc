// src/app/api/players/route.ts

import { NextRequest } from "next/server";
import { findPlayersByAccountId } from "./service";
import { accountManagementZodValidator } from "./validator";
import { z } from "zod";
import { checkAuthMiddleware, privateRoute } from "@/lib/jwt";
import { apiResponse } from "@/lib/utils";

export async function GET(req: NextRequest) {
  return privateRoute(req, async (req) => {
    try {
      const { error } = checkAuthMiddleware(req);
      if (error) {
        return error;
      }

      const queryParams = accountManagementZodValidator.parse({
        accountId: req.nextUrl.searchParams.get("accountId"),
      });

      const { accountId } = queryParams;
      const players = await findPlayersByAccountId(Number(accountId));

      return apiResponse(200, { players });

    } catch (err) {
      const errorMessage = err instanceof z.ZodError
        ? err.errors.map(e => e.message).join(", ")
        : "Erro ao processar a solicitação.";

      const statusCode = err instanceof z.ZodError ? 400 : 500;

      return apiResponse(statusCode, { message: errorMessage });
    }
  });
}
