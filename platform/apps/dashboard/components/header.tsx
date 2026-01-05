/**
 * Dashboard Header Component
 */

"use client";

export function Header() {
  return (
    <header className="bg-white border-b border-gray-200 px-6 py-4">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-semibold text-gray-900">Dashboard</h1>
          <p className="text-sm text-gray-500 mt-1">Manage your store</p>
        </div>
        <div className="flex items-center space-x-4">
          <button className="p-2 text-gray-400 hover:text-gray-600">
            <span className="text-xl">🔔</span>
          </button>
          <button className="p-2 text-gray-400 hover:text-gray-600">
            <span className="text-xl">⚙️</span>
          </button>
          <div className="w-10 h-10 bg-gray-300 rounded-full"></div>
        </div>
      </div>
    </header>
  );
}

