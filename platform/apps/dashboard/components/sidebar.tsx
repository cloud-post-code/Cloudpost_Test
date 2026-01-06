/**
 * Dashboard Sidebar Navigation Component
 */

"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { cn } from "@/lib/utils";
import { useState, useEffect } from "react";

const navigation = [
  { name: "Orders", href: "/dashboard/orders", icon: "🛒" },
  { name: "Wallet", href: "/dashboard/wallet", icon: "💰" },
  { name: "Account", href: "/dashboard/account", icon: "👤" },
];

const shopNavigation = [
  { name: "Info, Address & Settings", href: "/dashboard/shop/info", icon: "ℹ️" },
  { name: "Esthetic & Shop Info", href: "/dashboard/shop/esthetic", icon: "🎨" },
  { name: "Shipping", href: "/dashboard/shipping", icon: "🚚" },
  { name: "Pickup Locations", href: "/dashboard/shop/pickup", icon: "📦" },
];

const productsNavigation = [
  { name: "Products", href: "/dashboard/products", icon: "📦" },
  { name: "Inventory", href: "/dashboard/inventory", icon: "📋" },
  { name: "Product Options", href: "/dashboard/shop/products/options", icon: "⚙️" },
  { name: "Tags", href: "/dashboard/shop/products/tags", icon: "🏷️" },
];

export function Sidebar() {
  const pathname = usePathname();
  const isShopSection = (pathname?.startsWith("/dashboard/shop") && !pathname?.startsWith("/dashboard/shop/products")) || pathname?.startsWith("/dashboard/shipping");
  
  // Check if any product navigation item is active
  const isProductNavActive = productsNavigation.some(
    (item) => pathname === item.href || pathname?.startsWith(item.href + "/")
  );
  
  // Auto-open products dropdown if any product page is active
  const [isShopOpen, setIsShopOpen] = useState(false);
  const [isProductsOpen, setIsProductsOpen] = useState(isProductNavActive);

  // Keep products dropdown open when navigating to product pages
  useEffect(() => {
    if (isProductNavActive) {
      setIsProductsOpen(true);
    }
  }, [isProductNavActive]);

  // Auto-open shop dropdown if any shop page is active
  useEffect(() => {
    if (isShopSection) {
      setIsShopOpen(true);
    }
  }, [isShopSection]);

  return (
    <aside className="w-64 bg-white border-r border-gray-200 flex flex-col">
      <div className="p-6 border-b border-gray-200">
        <h2 className="text-2xl font-bold text-gray-900">Cloudpost</h2>
        <p className="text-sm text-gray-500 mt-1">Seller Dashboard</p>
      </div>
      <nav className="flex-1 p-4 space-y-1 overflow-y-auto">
        {/* Dashboard - First */}
        <Link
          href="/dashboard"
          className={cn(
            "flex items-center px-4 py-3 text-sm font-medium rounded-lg transition-colors",
            pathname === "/dashboard"
              ? "bg-blue-50 text-blue-700"
              : "text-gray-700 hover:bg-gray-50 hover:text-gray-900"
          )}
        >
          <span className="mr-3 text-lg">📊</span>
          Dashboard
        </Link>

        {/* Shop Dropdown */}
        <div>
          <button
            onClick={() => setIsShopOpen(!isShopOpen)}
            className={cn(
              "w-full flex items-center justify-between px-4 py-3 text-sm font-medium rounded-lg transition-colors",
              isShopSection
                ? "bg-blue-50 text-blue-700"
                : "text-gray-700 hover:bg-gray-50 hover:text-gray-900"
            )}
          >
            <div className="flex items-center">
              <span className="mr-3 text-lg">🏪</span>
              Shop
            </div>
            <span className={cn("transition-transform", isShopOpen && "rotate-180")}>
              ▼
            </span>
          </button>
          {isShopOpen && (
            <div className="ml-4 mt-1 space-y-1">
              {shopNavigation.map((item) => {
                const isActive = pathname === item.href || pathname?.startsWith(item.href + "/");
                return (
                  <Link
                    key={item.name}
                    href={item.href}
                    className={cn(
                      "flex items-center px-4 py-2 text-sm rounded-lg transition-colors",
                      isActive
                        ? "bg-blue-50 text-blue-700 font-medium"
                        : "text-gray-600 hover:bg-gray-50 hover:text-gray-900"
                    )}
                  >
                    <span className="mr-2 text-sm">{item.icon}</span>
                    {item.name}
                  </Link>
                );
              })}
            </div>
          )}
        </div>

        {/* Products - Standalone collapsible menu */}
        <div>
          <button
            onClick={() => setIsProductsOpen(!isProductsOpen)}
            className="w-full flex items-center justify-between px-4 py-3 text-sm font-medium rounded-lg transition-colors text-gray-700 hover:bg-gray-50 hover:text-gray-900"
          >
            <div className="flex items-center">
              <span className="mr-3 text-lg">📦</span>
              Products
            </div>
            <span className={cn("transition-transform", isProductsOpen && "rotate-180")}>
              ▼
            </span>
          </button>
          {isProductsOpen && (
            <div className="ml-4 mt-1 space-y-1">
              {productsNavigation.map((item) => {
                const isActive = pathname === item.href || pathname?.startsWith(item.href + "/");
                return (
                  <Link
                    key={item.name}
                    href={item.href}
                    className={cn(
                      "flex items-center px-4 py-2 text-sm rounded-lg transition-colors",
                      isActive
                        ? "bg-blue-50 text-blue-700 font-medium"
                        : "text-gray-600 hover:bg-gray-50 hover:text-gray-900"
                    )}
                  >
                    <span className="mr-2 text-sm">{item.icon}</span>
                    {item.name}
                  </Link>
                );
              })}
            </div>
          )}
        </div>

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

