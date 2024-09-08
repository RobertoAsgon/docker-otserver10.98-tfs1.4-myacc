import { z } from 'zod';

export const createAccountValidator = z.object({
  name: z.string().min(3, "O nome deve ter no mínimo 3 caracteres."),
  password: z.string().min(6, "A senha deve ter no mínimo 6 caracteres."),
  email: z.string().email("O email deve ser válido."),
});
