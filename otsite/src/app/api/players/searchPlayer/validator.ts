
import { z } from 'zod';

export const searchPlayerZodValidator = z.object({
  name: z.string().min(1, "O nome é obrigatório."),
});