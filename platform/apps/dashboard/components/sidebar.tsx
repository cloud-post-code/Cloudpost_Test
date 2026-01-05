/**
 * Dashboard Sidebar Navigation Component
 */

"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { cn } from "@/lib/utils";

const navigation = [
  { name: "Dashboard", href: "/dashboard", icon: "📊" },
  { name: "Shop", href: "/dashboard/shop", icon: "🏪" },
  { name: "Products", href: "/dashboard/products", icon: "📦" },
  { name: "Inventory", href: "/dashboard/inventory", icon: "📋" },
  { name: "Orders", href: "/dashboard/orders", icon: "🛒" },
  { name: "Shipping", href: "/dashboard/shipping", icon: "🚚" },
  { name: "Wallet", href: "/dashboard/wallet", icon: "💰" },
  { name: "Account", href: "/dashboard/account", icon: "👤" },
];

export function Sidebar() {
  const pathname = usePathname();

  return (
    <aside className="w-64 bg-white border-r border-gray-200 flex flex-col">
      <div className="p-6 border-b border-gray-200">
        <h2 className="text-2xl font-bold text-gray-900">Cloudpost</h2>
        <p className="text-sm text-gray-500 mt-1">Seller Dashboard</p>
      </div>
      <nav className="flex-1 p-4 space-y-1">
        {navigation.map((item) => {
          const isActive = pathname === item.href || pathname?.startsWith(item.href + "/");
          return (
            <Link
              key={item.name}
              href={item.href}
              className={cn(
                "flex items-center px-4 py-3 text-sm font-medium rounded-lg transition-colors",
                isActive
                  ? "bg-blue-50 text-blue-700"
                  : "text-gray-700 hover:bg-gray-50 hover:text-gray-900"
              )}
            >
              <span className="mr-3 text-lg">{item.icon}</span>
              {item.name}
            </Link>
          );
        })}
      </nav>
      <div className="p-4 border-t border-gray-200">
        <div className="flex items-center px-4 py-2">
          <div className="w-8 h-8 bg-gray-300 rounded-full"></div>
          <div className="ml-3">
            <p className="text-sm font-medium text-gray-900">Seller Name</p>
            <p className="text-xs text-gray-500">seller@example.com</p>
          </div>
        </div>
      </div>
    </aside>
  );
}

