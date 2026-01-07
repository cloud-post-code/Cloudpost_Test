'use client';

import { useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { useAuthStore } from '@/store/authStore';
import Link from 'next/link';

export default function DashboardPage() {
  const router = useRouter();
  const { user, isAuthenticated, isLoading, checkAuth, logout } = useAuthStore();

  useEffect(() => {
    checkAuth();
  }, [checkAuth]);

  useEffect(() => {
    if (!isLoading && !isAuthenticated) {
      router.push('/login');
    }
  }, [isAuthenticated, isLoading, router]);

  const handleLogout = async () => {
    await logout();
    router.push('/login');
  };

  if (isLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-lg">Loading...</div>
      </div>
    );
  }

  if (!isAuthenticated || !user) {
    return null;
  }

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="bg-white shadow-sm">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center py-4">
            <div className="flex items-center">
              <h1 className="text-2xl font-bold text-gray-900">Cloudpost</h1>
              <span className="ml-4 text-gray-500">Seller Portal</span>
            </div>
            <div className="flex items-center space-x-4">
              <span className="text-gray-700">Welcome, {user.name}</span>
              <button
                onClick={handleLogout}
                className="text-gray-700 hover:text-gray-900"
              >
                Logout
              </button>
            </div>
          </div>
        </div>
      </header>

      {/* Dashboard Content */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <h2 className="text-3xl font-bold mb-8">Dashboard</h2>

        {/* Stats Grid */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <div className="bg-white p-6 rounded-lg shadow">
            <h3 className="text-lg font-semibold text-gray-700 mb-2">Total Products</h3>
            <p className="text-3xl font-bold text-blue-600">0</p>
            <p className="text-sm text-gray-500 mt-2">Manage your products</p>
          </div>
          <div className="bg-white p-6 rounded-lg shadow">
            <h3 className="text-lg font-semibold text-gray-700 mb-2">Total Orders</h3>
            <p className="text-3xl font-bold text-green-600">0</p>
            <p className="text-sm text-gray-500 mt-2">View all orders</p>
          </div>
          <div className="bg-white p-6 rounded-lg shadow">
            <h3 className="text-lg font-semibold text-gray-700 mb-2">Revenue</h3>
            <p className="text-3xl font-bold text-purple-600">$0</p>
            <p className="text-sm text-gray-500 mt-2">Total earnings</p>
          </div>
        </div>

        {/* Quick Actions */}
        <div className="bg-white rounded-lg shadow p-6">
          <h3 className="text-xl font-semibold mb-4">Quick Actions</h3>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            <Link
              href="/products"
              className="p-4 border border-gray-200 rounded-lg hover:bg-gray-50 transition"
            >
              <h4 className="font-medium mb-2">Add Product</h4>
              <p className="text-sm text-gray-600">Create a new product listing</p>
            </Link>
            <Link
              href="/orders"
              className="p-4 border border-gray-200 rounded-lg hover:bg-gray-50 transition"
            >
              <h4 className="font-medium mb-2">View Orders</h4>
              <p className="text-sm text-gray-600">Manage your orders</p>
            </Link>
            <Link
              href="/analytics"
              className="p-4 border border-gray-200 rounded-lg hover:bg-gray-50 transition"
            >
              <h4 className="font-medium mb-2">Analytics</h4>
              <p className="text-sm text-gray-600">View sales analytics</p>
            </Link>
            <Link
              href="/settings"
              className="p-4 border border-gray-200 rounded-lg hover:bg-gray-50 transition"
            >
              <h4 className="font-medium mb-2">Settings</h4>
              <p className="text-sm text-gray-600">Account settings</p>
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}

