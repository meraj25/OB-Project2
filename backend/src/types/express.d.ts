// src/types/express.d.ts
import "express";

declare global {
  namespace Express {
    interface Request {
      user?: { user_id: number; name: string };
    }
  }
}