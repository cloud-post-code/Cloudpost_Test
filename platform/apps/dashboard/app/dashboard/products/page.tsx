"use client";

/**
 * Products List Page
 * Display products with search, filter, and pagination
 */

import React, { useState } from "react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { getProductOptions } from "./api/productApi";
import { ProductOptionForm } from "../shop/products/options/components/ProductOptionForm";

const queryClient = new QueryClient();

function ProductsPageContent() {
  const [showOptionForm, setShowOptionForm] = useState(false);
  const queryClientInstance = useQueryClient();

  useQuery({
    queryKey: ["productOptions"],
    queryFn: getProductOptions,
  });

  const handleOptionCreated = () => {
    setShowOptionForm(false);
    queryClientInstance.invalidateQueries({ queryKey: ["productOptions"] });
  };

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-3xl font-bold">Products</h1>
        <div className="flex gap-3">
          <button
            onClick={() => setShowOptionForm(true)}
            className="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700"
          >
            Add Custom Option
          </button>
          <a
            href="/dashboard/products/new"
            className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700"
          >
            Add Product
          </a>
        </div>
      </div>
      <div className="bg-white rounded-lg shadow">
        <div className="p-4 border-b border-gray-200">
          <div className="flex space-x-4">
            <input
              type="text"
              placeholder="Search products..."
              className="flex-1 px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
            <select className="px-4 py-2 border border-gray-300 rounded-md">
              <option>All Categories</option>
            </select>
            <select className="px-4 py-2 border border-gray-300 rounded-md">
              <option>All Status</option>
            </select>
          </div>
        </div>
        <div className="p-4">
          <table className="w-full">
            <thead>
              <tr className="border-b border-gray-200">
                <th className="text-left py-3 px-4 font-medium text-gray-700">Product</th>
                <th className="text-left py-3 px-4 font-medium text-gray-700">SKU</th>
                <th className="text-left py-3 px-4 font-medium text-gray-700">Price</th>
                <th className="text-left py-3 px-4 font-medium text-gray-700">Stock</th>
                <th className="text-left py-3 px-4 font-medium text-gray-700">Status</th>
                <th className="text-left py-3 px-4 font-medium text-gray-700">Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr className="border-b border-gray-100">
                <td className="py-3 px-4">Sample Product</td>
                <td className="py-3 px-4">SKU-001</td>
                <td className="py-3 px-4">$99.99</td>
                <td className="py-3 px-4">50</td>
                <td className="py-3 px-4">
                  <span className="px-2 py-1 bg-green-100 text-green-800 rounded text-sm">
                    Active
                  </span>
                </td>
                <td className="py-3 px-4">
                  <button className="text-blue-600 hover:text-blue-800 mr-3">Edit</button>
                  <button className="text-red-600 hover:text-red-800">Delete</button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      {/* Custom Option Form Modal */}
      {showOptionForm && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
          <div className="bg-white rounded-lg shadow-xl max-w-2xl w-full mx-4 max-h-[90vh] overflow-y-auto">
            <div className="p-6">
              <div className="flex justify-between items-center mb-4">
                <h2 className="text-2xl font-bold">Create Product Option</h2>
                <button
                  onClick={() => setShowOptionForm(false)}
                  className="text-gray-500 hover:text-gray-700"
                >
                  <svg
                    className="w-6 h-6"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M6 18L18 6M6 6l12 12"
                    />
                  </svg>
                </button>
              </div>
              <ProductOptionForm
                onSuccess={handleOptionCreated}
                onCancel={() => setShowOptionForm(false)}
              />
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

export default function ProductsPage() {
  return (
    <QueryClientProvider client={queryClient}>
      <ProductsPageContent />
    </QueryClientProvider>
  );
}

