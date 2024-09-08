import { z } from 'zod';

export const createPlayerZodValidator = z.object({
  name: z.string().min(1, "O nome é obrigatório."),
  vocation: z.number().min(1, "A senha é obrigatória."),
});
