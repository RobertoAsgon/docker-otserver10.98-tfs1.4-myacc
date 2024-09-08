import { NextRequest, NextResponse } from 'next/server';
import jwt from 'jsonwebtoken';
import { apiResponse } from './utils';
import { User } from '@/types/User';

export const JWT_SECRET = process.env.JWT_SECRET || 'nto-key-jwt-369';

export function authMiddleware(req: NextRequest) {
  const token = req.headers.get('authorization')?.split(' ')[1];

  if (!token) {
    return apiResponse(401, { message: 'Token não fornecido.' });
  }

  try {
    const decoded = jwt.verify(token, JWT_SECRET) as User;
    return { user: decoded };
  } catch (err) {
    return apiResponse(401, { message: 'Token inválido ou expirado.' });
  }
}

export function checkAuthMiddleware(req: NextRequest) {
  const authResult = authMiddleware(req);

  if (authResult instanceof NextResponse) {
    return { error: authResult };
  }

  const { user } = authResult as { user: User };
  return { user };
}

type Handler = (req: NextRequest, user: User) => Promise<NextResponse> | NextResponse;

export async function privateRoute(req: NextRequest, routeHandler: Handler): Promise<NextResponse> {
  const { error, user } = checkAuthMiddleware(req);

  if (error) {
    return error;
  }

  return routeHandler(req, user);
}
