import { z } from 'zod';

export const loginAccountZodValidator = z.object({
  name: z.string().min(1, "O nome é obrigatório."),
  password: z.string().min(1, "A senha é obrigatória."),
});
