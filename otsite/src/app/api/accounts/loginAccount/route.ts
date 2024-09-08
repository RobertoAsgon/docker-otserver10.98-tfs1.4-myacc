import { NextRequest } from "next/server";
import { z } from 'zod';
import { authenticateUser } from "./service";
import { loginAccountZodValidator } from "./validator";
import { apiResponse } from "@/lib/utils";

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { name, password } = loginAccountZodValidator.parse(body);

    const authResult = await authenticateUser(name, password);

    if (!authResult) {
      return apiResponse(401, { message: "Credenciais inválidas." });
    }

    return apiResponse(200, { message: "Login bem-sucedido!", token: authResult.token });
  } catch (err) {
    if (err instanceof z.ZodError) {
      return apiResponse(400, { message: err.errors.map(e => e.message).join(", ") });
    }
    return apiResponse(500, { message: "Houve um problema ao realizar o login." });
  }
}
