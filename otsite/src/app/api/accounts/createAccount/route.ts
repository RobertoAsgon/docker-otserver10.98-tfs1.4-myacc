import { NextRequest } from "next/server";
import { createAccountValidator } from "./validator";
import { createAccount } from "./service";
import { z } from "zod";
import { apiResponse } from "@/lib/utils";

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const validatedParams = createAccountValidator.parse(body);

    const { name, password, email } = validatedParams;

    const { success, message } = await createAccount(name, password, email);

    return success
      ? apiResponse(201, { message: "Conta criada com sucesso!" })
      : apiResponse(400, { message });

  } catch (err) {
    console.log("err", err)
    const errorMessage = err instanceof z.ZodError
      ? err.errors.map(e => e.message).join(", ")
      : "Houve um problema ao criar a conta.";

    const statusCode = err instanceof z.ZodError ? 400 : 500;

    return apiResponse(statusCode, { message: errorMessage });
  }
}
