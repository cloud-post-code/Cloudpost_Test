/**
 * Breadcrumb Navigation Component
 */

"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

export function Breadcrumb() {
  const pathname = usePathname();
  const paths = pathname?.split("/").filter(Boolean) || [];

  return (
    <nav className="flex items-center space-x-2 text-sm text-gray-500 mb-4">
      <Link href="/dashboard" className="hover:text-gray-700">
        Dashboard
      </Link>
      {paths.slice(1).map((path, index) => {
        const href = "/" + paths.slice(0, index + 2).join("/");
        const isLast = index === paths.length - 2;
        return (
          <span key={path}>
            <span className="mx-2">/</span>
            {isLast ? (
              <span className="text-gray-900 font-medium capitalize">{path}</span>
            ) : (
              <Link href={href} className="hover:text-gray-700 capitalize">
                {path}
              </Link>
            )}
          </span>
        );
      })}
    </nav>
  );
}

