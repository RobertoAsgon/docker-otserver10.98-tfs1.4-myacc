import { NextResponse } from "next/server";
import crypto from 'crypto';

export const apiResponse = (status: number, data: object | null = null) => {
  if (status === 204) {
    return new NextResponse(null, {
      status: 204,
    });
  }

  return new NextResponse(JSON.stringify(data), {
    status: status,
    headers: {
      'Content-Type': 'application/json',
    },
  });
};

export function getSha1Hash(input: string): string {
  return crypto.createHash('sha1').update(input).digest('hex');
}