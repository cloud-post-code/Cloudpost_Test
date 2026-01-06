"use client";

/**
 * Product Options Management Page
 * Manage product options and their values
 */

import { useState } from "react";
import { useQuery, QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { getProductOptions, ProductOption } from "../../../api/productApi";
import { SidePanel } from "@/components/side-panel";
import { ProductOptionForm } from "./components/ProductOptionForm";
import { getCurrentUser } from "@/lib/auth";

const queryClient = new QueryClient();

function ProductOptionsPageContent() {
  const [isPanelOpen, setIsPanelOpen] = useState(false);
  const currentUser = getCurrentUser();

  const { data: productOptions = [], isLoading } = useQuery({
    queryKey: ["productOptions"],
    queryFn: getProductOptions,
  });

  // Filter options by current user (if user is available)
  const userOptions = currentUser
    ? productOptions.filter((opt) => {
        // Note: The API should filter by user, but we can also filter here
        // This assumes the option has a sellerId property
        return true; // For now, show all options until backend filtering is implemented
      })
    : productOptions;

  const handleOptionCreated = () => {
    setIsPanelOpen(false);
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="text-gray-500">Loading product options...</div>
      </div>
    );
  }

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <div>
          <h1 className="text-3xl font-bold">Product Options</h1>
          <p className="text-gray-500 mt-1">
            Manage product options and their values. Options are attached to your account.
          </p>
        </div>
        <button
          onClick={() => setIsPanelOpen(true)}
          className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition-colors"
        >
          + Add Option
        </button>
      </div>

      {userOptions.length === 0 ? (
        <div className="bg-white rounded-lg shadow p-12 text-center">
          <svg
            className="mx-auto h-12 w-12 text-gray-400"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
            />
          </svg>
          <h3 className="mt-4 text-lg font-medium text-gray-900">
            No product options yet
          </h3>
          <p className="mt-2 text-sm text-gray-500">
            Get started by creating your first product option.
          </p>
          <button
            onClick={() => setIsPanelOpen(true)}
            className="mt-6 px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700"
          >
            Create Your First Option
          </button>
        </div>
      ) : (
        <div className="bg-white rounded-lg shadow overflow-hidden">
          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Option Name
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Type
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Values
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Identifier
                  </th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {userOptions.map((option) => (
                  <tr key={option.id} className="hover:bg-gray-50">
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="text-sm font-medium text-gray-900">
                        {option.name}
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-blue-100 text-blue-800">
                        {option.type === 1
                          ? "Dropdown"
                          : option.type === 2
                          ? "Radio"
                          : "Checkbox"}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      <div className="text-sm text-gray-900">
                        {option.values.length > 0 ? (
                          <div className="flex flex-wrap gap-2">
                            {option.values.map((value) => (
                              <span
                                key={value.id}
                                className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-800"
                              >
                                {value.name}
                                {value.colorCode && (
                                  <span
                                    className="ml-2 w-3 h-3 rounded-full border border-gray-300"
                                    style={{ backgroundColor: value.colorCode }}
                                  />
                                )}
                              </span>
                            ))}
                          </div>
                        ) : (
                          <span className="text-gray-400">No values</span>
                        )}
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      {option.identifier}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      <SidePanel
        isOpen={isPanelOpen}
        onClose={() => setIsPanelOpen(false)}
        title="Create Product Option"
        width="lg"
      >
        <ProductOptionForm
          onSuccess={handleOptionCreated}
          onCancel={() => setIsPanelOpen(false)}
          userId={currentUser?.id}
        />
      </SidePanel>
    </div>
  );
}

export default function ProductOptionsPage() {
  return (
    <QueryClientProvider client={queryClient}>
      <ProductOptionsPageContent />
    </QueryClientProvider>
  );
}

