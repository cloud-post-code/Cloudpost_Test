"use client";

/**
 * Product Inventory Page
 * Step 2: Set price and quantity for each product option combination
 */

import React, { useState, useEffect, Suspense } from "react";
import { useQuery, useMutation, QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { useRouter, useSearchParams } from "next/navigation";
import {
  getProductOptions,
  createInventory,
  CreateInventoryRequest,
  ProductOption,
} from "../../api/productApi";

const queryClient = new QueryClient();

interface OptionCombination {
  optionId: number;
  optionValueId: number;
  optionName: string;
  optionValueName: string;
}

interface InventoryFormItem {
  combination: OptionCombination[];
  price: number;
  quantity: number;
  sku: string;
}

// Generate all combinations of option values
function generateCombinations(
  options: { optionId: number; optionValueIds: number[] }[],
  productOptions: ProductOption[]
): OptionCombination[][] {
  if (options.length === 0) {
    return [[]];
  }

  const [firstOption, ...restOptions] = options;
  const restCombinations = generateCombinations(restOptions, productOptions);

  const firstOptionData = productOptions.find((o) => o.id === firstOption.optionId);
  if (!firstOptionData) return [];

  const combinations: OptionCombination[][] = [];

  for (const valueId of firstOption.optionValueIds) {
    const value = firstOptionData.values.find((v) => v.id === valueId);
    if (!value) continue;

    const optionCombination: OptionCombination = {
      optionId: firstOption.optionId,
      optionValueId: valueId,
      optionName: firstOptionData.name,
      optionValueName: value.name,
    };

    for (const restCombination of restCombinations) {
      combinations.push([optionCombination, ...restCombination]);
    }
  }

  return combinations;
}

function InventoryPageContent() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const productId = searchParams.get("productId");

  const [inventoryItems, setInventoryItems] = useState<InventoryFormItem[]>([]);

  const { data: productOptions = [] } = useQuery({
    queryKey: ["productOptions"],
    queryFn: getProductOptions,
  });

  // Get product options from localStorage (set in previous step)
  useEffect(() => {
    if (!productId) {
      router.push("/dashboard/products/new");
      return;
    }

    const storedOptions = localStorage.getItem(`product_options_${productId}`);
    if (storedOptions) {
      try {
        const options = JSON.parse(storedOptions);
        if (options.length > 0) {
          const combinations = generateCombinations(options, productOptions);
          
          const items: InventoryFormItem[] = combinations.map((combination) => ({
            combination,
            price: 0,
            quantity: 0,
            sku: "",
          }));

          setInventoryItems(items);
        } else {
          // No options - create a single base product entry
          setInventoryItems([
            {
              combination: [],
              price: 0,
              quantity: 0,
              sku: "",
            },
          ]);
        }
      } catch (error) {
        console.error("Failed to parse stored options:", error);
        // Fallback: create a single base product entry
        setInventoryItems([
          {
            combination: [],
            price: 0,
            quantity: 0,
            sku: "",
          },
        ]);
      }
    } else {
      // No stored options - create a single base product entry
      setInventoryItems([
        {
          combination: [],
          price: 0,
          quantity: 0,
          sku: "",
        },
      ]);
    }
  }, [productId, productOptions, router]);

  const createInventoryMutation = useMutation({
    mutationFn: createInventory,
    onSuccess: () => {
      // Clear stored options
      if (productId) {
        localStorage.removeItem(`product_options_${productId}`);
      }
      router.push("/dashboard/products");
    },
    onError: (error: Error) => {
      alert(`Failed to create inventory: ${error.message}`);
    },
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    if (!productId) {
      alert("Product ID is missing");
      return;
    }

    // Validate all items have price and quantity
    const invalidItems = inventoryItems.filter(
      (item) => !item.price || item.price <= 0 || !item.quantity || item.quantity < 0
    );

    if (invalidItems.length > 0) {
      alert("Please fill in price and quantity for all combinations");
      return;
    }

    const inventoryData: CreateInventoryRequest = {
      productId: parseInt(productId),
      items: inventoryItems.map((item) => ({
        optionCombination: item.combination.map((c) => ({
          optionId: c.optionId,
          optionValueId: c.optionValueId,
        })),
        price: item.price,
        quantity: item.quantity,
        sku: item.sku || undefined,
      })),
    };

    createInventoryMutation.mutate(inventoryData);
  };

  const updateInventoryItem = (
    index: number,
    field: "price" | "quantity" | "sku",
    value: number | string
  ) => {
    const updated = [...inventoryItems];
    updated[index] = { ...updated[index], [field]: value };
    setInventoryItems(updated);
  };

  const getCombinationLabel = (combination: OptionCombination[]): string => {
    if (combination.length === 0) {
      return "Base Product";
    }
    return combination.map((c) => `${c.optionName}: ${c.optionValueName}`).join(", ");
  };

  if (!productId) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="text-gray-500">Loading...</div>
      </div>
    );
  }


  return (
    <div className="max-w-6xl mx-auto">
      <h1 className="text-3xl font-bold mb-6">Product Inventory</h1>
      <p className="text-gray-600 mb-6">
        Set the price and quantity for each product option combination.
      </p>

      <form onSubmit={handleSubmit} className="space-y-6">
        <div className="bg-white rounded-lg shadow overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Option Combination
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Price *
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Quantity *
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    SKU
                  </th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {inventoryItems.map((item, index) => (
                  <tr key={index} className="hover:bg-gray-50">
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="text-sm font-medium text-gray-900">
                        {getCombinationLabel(item.combination)}
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <input
                        type="number"
                        step="0.01"
                        min="0"
                        value={item.price === 0 ? "" : item.price || ""}
                        onChange={(e) => {
                          const val = e.target.value;
                          if (val === "" || val === null || val === undefined) {
                            updateInventoryItem(index, "price", 0);
                          } else {
                            const numVal = parseFloat(val);
                            if (!isNaN(numVal) && numVal >= 0) {
                              updateInventoryItem(index, "price", numVal);
                            }
                          }
                        }}
                        onBlur={(e) => {
                          if (e.target.value === "" || parseFloat(e.target.value) < 0) {
                            updateInventoryItem(index, "price", 0);
                          }
                        }}
                        required
                        className="w-32 px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                      />
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <input
                        type="number"
                        min="0"
                        step="1"
                        value={item.quantity === 0 ? "" : item.quantity || ""}
                        onChange={(e) => {
                          const val = e.target.value;
                          if (val === "" || val === null || val === undefined) {
                            updateInventoryItem(index, "quantity", 0);
                          } else {
                            const numVal = parseInt(val, 10);
                            if (!isNaN(numVal) && numVal >= 0) {
                              updateInventoryItem(index, "quantity", numVal);
                            }
                          }
                        }}
                        onBlur={(e) => {
                          if (e.target.value === "" || parseInt(e.target.value, 10) < 0) {
                            updateInventoryItem(index, "quantity", 0);
                          }
                        }}
                        required
                        className="w-32 px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                      />
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <input
                        type="text"
                        value={item.sku}
                        onChange={(e) => updateInventoryItem(index, "sku", e.target.value)}
                        placeholder="Auto-generated if empty"
                        className="w-48 px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                      />
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        <div className="flex justify-end space-x-4 pt-4">
          <button
            type="button"
            onClick={() => router.back()}
            className="px-6 py-2 border border-gray-300 rounded-md text-gray-700 hover:bg-gray-50"
          >
            Back
          </button>
          <button
            type="submit"
            disabled={createInventoryMutation.isPending}
            className="px-6 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {createInventoryMutation.isPending ? "Saving..." : "Save Inventory"}
          </button>
        </div>
      </form>
    </div>
  );
}

function InventoryPageLoading() {
  return (
    <div className="flex items-center justify-center min-h-[400px]">
      <div className="text-gray-500">Loading...</div>
    </div>
  );
}

export default function InventoryPage() {
  return (
    <QueryClientProvider client={queryClient}>
      <Suspense fallback={<InventoryPageLoading />}>
        <InventoryPageContent />
      </Suspense>
    </QueryClientProvider>
  );
}

