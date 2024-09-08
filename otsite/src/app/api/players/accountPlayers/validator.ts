import { z } from 'zod';

export const accountManagementZodValidator = z.object({
  accountId: z.string().regex(/^\d+$/, "accountId deve ser um número positivo."),
});
