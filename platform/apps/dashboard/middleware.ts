/**
 * Next.js middleware for protected routes
 * Placeholder implementation - will be completed later
 */

import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  // TODO: Implement actual auth check
  // For now, allow all requests
  return NextResponse.next();
}

export const config = {
  matcher: ["/dashboard/:path*"],
};

