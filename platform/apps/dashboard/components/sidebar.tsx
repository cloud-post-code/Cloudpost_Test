/**
 * Dashboard Sidebar Navigation Component
 */

"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { cn } from "@/lib/utils";
import { useState } from "react";

const navigation = [
  { name: "Orders", href: "/dashboard/orders", icon: "🛒" },
  { name: "Shipping", href: "/dashboard/shipping", icon: "🚚" },
  { name: "Wallet", href: "/dashboard/wallet", icon: "💰" },
  { name: "Account", href: "/dashboard/account", icon: "👤" },
];

const shopNavigation = [
  { name: "Info", href: "/dashboard/shop/info", icon: "ℹ️" },
  { name: "Address", href: "/dashboard/shop/address", icon: "📍" },
  { name: "Settings", href: "/dashboard/shop/settings", icon: "⚙️" },
  { name: "Esthetic", href: "/dashboard/shop/esthetic", icon: "🎨" },
  { name: "Shop Info", href: "/dashboard/shop/info-pages", icon: "📄" },
  { name: "Pickup Locations", href: "/dashboard/shop/pickup", icon: "📦" },
];

const productsNavigation = [
  { name: "Product Options", href: "/dashboard/shop/products/options", icon: "⚙️" },
  { name: "Tags", href: "/dashboard/shop/products/tags", icon: "🏷️" },
  { name: "Products", href: "/dashboard/shop/products", icon: "📦" },
];

const inventoryNavigation = [
  { name: "Inventory", href: "/dashboard/products/new/inventory", icon: "📋" },
];

export function Sidebar() {
  const pathname = usePathname();
  const isShopSection = pathname?.startsWith("/dashboard/shop") && !pathname?.startsWith("/dashboard/shop/products");
  const isProductsSection = pathname?.startsWith("/dashboard/shop/products");
  const isInventorySection = pathname?.startsWith("/dashboard/products");
  const [isShopOpen, setIsShopOpen] = useState(false);
  const [isProductsOpen, setIsProductsOpen] = useState(false);
  const [isInventoryOpen, setIsInventoryOpen] = useState(false);

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
                const isActive = pathname === item.href;
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
            className={cn(
              "w-full flex items-center justify-between px-4 py-3 text-sm font-medium rounded-lg transition-colors",
              isProductsSection
                ? "bg-blue-50 text-blue-700"
                : "text-gray-700 hover:bg-gray-50 hover:text-gray-900"
            )}
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

        {/* Inventory - Standalone collapsible menu */}
        <div>
          <button
            onClick={() => setIsInventoryOpen(!isInventoryOpen)}
            className={cn(
              "w-full flex items-center justify-between px-4 py-3 text-sm font-medium rounded-lg transition-colors",
              isInventorySection
                ? "bg-blue-50 text-blue-700"
                : "text-gray-700 hover:bg-gray-50 hover:text-gray-900"
            )}
          >
            <div className="flex items-center">
              <span className="mr-3 text-lg">📋</span>
              Inventory
            </div>
            <span className={cn("transition-transform", isInventoryOpen && "rotate-180")}>
              ▼
            </span>
          </button>
          {isInventoryOpen && (
            <div className="ml-4 mt-1 space-y-1">
              {inventoryNavigation.map((item) => {
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

