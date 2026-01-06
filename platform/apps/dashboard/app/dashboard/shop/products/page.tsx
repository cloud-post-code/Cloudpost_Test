"use client";

/**
 * Products List Page
 * Display products with multi-select, bulk actions, and per-product actions
 */

import { useState } from "react";
import { useQuery, useMutation, useQueryClient, QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { useRouter } from "next/navigation";
import Link from "next/link";
import {
  getProductList,
  bulkActivateProducts,
  bulkDeactivateProducts,
  bulkDeleteProducts,
  getProductForClone,
  getProductInventory,
  ProductListItem,
  InventoryItem,
} from "../../products/api/productApi";
import { cn } from "@/lib/utils";
import { SidePanel } from "@/components/side-panel";

const queryClient = new QueryClient();

interface InventoryViewProps {
  productId: number;
  productName: string;
  onClose: () => void;
}

function InventoryView({ productId, productName, onClose }: InventoryViewProps) {
  const { data: inventory = [], isLoading } = useQuery({
    queryKey: ["productInventory", productId],
    queryFn: () => getProductInventory(productId),
  });

  const getCombinationLabel = (item: InventoryItem): string => {
    if (item.optionCombination.length === 0) {
      return "Base Product";
    }
    return item.optionCombination
      .map((c) => `${c.optionName || `Option ${c.optionId}`}: ${c.optionValueName || `Value ${c.optionValueId}`}`)
      .join(", ");
  };

  return (
    <div className="space-y-4">
      <div>
        <h3 className="text-lg font-semibold mb-2">Inventory for: {productName}</h3>
        {isLoading ? (
          <div className="text-gray-500">Loading inventory...</div>
        ) : inventory.length === 0 ? (
          <div className="text-gray-500">No inventory items found for this product.</div>
        ) : (
          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Variant</th>
                  <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">SKU</th>
                  <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Price</th>
                  <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Quantity</th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {inventory.map((item) => (
                  <tr key={item.id}>
                    <td className="px-4 py-3 text-sm text-gray-900">{getCombinationLabel(item)}</td>
                    <td className="px-4 py-3 text-sm text-gray-500">{item.sku || "-"}</td>
                    <td className="px-4 py-3 text-sm text-gray-900">${item.price.toFixed(2)}</td>
                    <td className="px-4 py-3 text-sm text-gray-900">{item.quantity}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
      <div className="flex justify-end">
        <button
          onClick={onClose}
          className="px-4 py-2 border border-gray-300 rounded-md text-gray-700 hover:bg-gray-50"
        >
          Close
        </button>
      </div>
    </div>
  );
}

function ProductsPageContent() {
  const router = useRouter();
  const queryClient = useQueryClient();
  const [selectedProducts, setSelectedProducts] = useState<number[]>([]);
  const [searchQuery, setSearchQuery] = useState("");
  const [showInventory, setShowInventory] = useState<{ productId: number; productName: string } | null>(null);

  // Fetch products
  const { data: productsData, isLoading } = useQuery({
    queryKey: ["productList"],
    queryFn: getProductList,
  });

  // Bulk mutations
  const activateMutation = useMutation({
    mutationFn: bulkActivateProducts,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["productList"] });
      setSelectedProducts([]);
    },
  });

  const deactivateMutation = useMutation({
    mutationFn: bulkDeactivateProducts,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["productList"] });
      setSelectedProducts([]);
    },
  });

  const deleteMutation = useMutation({
    mutationFn: bulkDeleteProducts,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["productList"] });
      setSelectedProducts([]);
    },
  });

  const handleSelectAll = (checked: boolean) => {
    if (checked) {
      setSelectedProducts(productsData?.data.map((p) => p.id) || []);
    } else {
      setSelectedProducts([]);
    }
  };

  const handleSelectProduct = (productId: number, checked: boolean) => {
    if (checked) {
      setSelectedProducts([...selectedProducts, productId]);
    } else {
      setSelectedProducts(selectedProducts.filter((id) => id !== productId));
    }
  };

  const handleBulkActivate = async () => {
    if (selectedProducts.length === 0) return;
    if (!confirm(`Activate ${selectedProducts.length} product(s)?`)) return;
    try {
      await activateMutation.mutateAsync(selectedProducts);
    } catch (error) {
      alert("Failed to activate products");
    }
  };

  const handleBulkDeactivate = async () => {
    if (selectedProducts.length === 0) return;
    if (!confirm(`Deactivate ${selectedProducts.length} product(s)?`)) return;
    try {
      await deactivateMutation.mutateAsync(selectedProducts);
    } catch (error) {
      alert("Failed to deactivate products");
    }
  };

  const handleBulkDelete = async () => {
    if (selectedProducts.length === 0) return;
    if (!confirm(`Delete ${selectedProducts.length} product(s)? This action cannot be undone.`)) return;
    try {
      await deleteMutation.mutateAsync(selectedProducts);
    } catch (error) {
      alert("Failed to delete products");
    }
  };

  const handleCloneProduct = async (productId: number) => {
    try {
      const cloneData = await getProductForClone(productId);
      // Store clone data in sessionStorage to pre-fill the form
      sessionStorage.setItem("productCloneData", JSON.stringify(cloneData));
      router.push("/dashboard/products/new");
    } catch (error) {
      alert("Failed to load product data for cloning");
    }
  };

  const handleViewInventory = (product: ProductListItem) => {
    setShowInventory({ productId: product.id, productName: product.name });
  };

  // Filter products based on search
  const filteredProducts =
    productsData?.data.filter(
      (product) =>
        product.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
        product.identifier.toLowerCase().includes(searchQuery.toLowerCase()) ||
        product.sku?.toLowerCase().includes(searchQuery.toLowerCase()) ||
        product.tags.some((tag) =>
          tag.name.toLowerCase().includes(searchQuery.toLowerCase())
        )
    ) || [];

  const allSelected = filteredProducts.length > 0 && selectedProducts.length === filteredProducts.length;
  const someSelected = selectedProducts.length > 0 && selectedProducts.length < filteredProducts.length;

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="text-gray-500">Loading products...</div>
      </div>
    );
  }

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <div>
          <h1 className="text-3xl font-bold">Products</h1>
          <p className="text-gray-500 mt-1">
            Manage your products. Select multiple products to perform bulk actions.
          </p>
        </div>
        <Link
          href="/dashboard/products/new"
          className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700"
        >
          Add Product
        </Link>
      </div>

      {/* Bulk Actions Bar */}
      {selectedProducts.length > 0 && (
        <div className="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-6">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <span className="text-sm font-medium text-blue-900">
                {selectedProducts.length} product(s) selected
              </span>
              <div className="flex gap-2">
                <button
                  onClick={handleBulkActivate}
                  disabled={activateMutation.isPending}
                  className="px-3 py-1.5 bg-green-600 text-white rounded-md hover:bg-green-700 disabled:opacity-50 text-sm"
                >
                  Activate
                </button>
                <button
                  onClick={handleBulkDeactivate}
                  disabled={deactivateMutation.isPending}
                  className="px-3 py-1.5 bg-yellow-600 text-white rounded-md hover:bg-yellow-700 disabled:opacity-50 text-sm"
                >
                  Deactivate
                </button>
                <button
                  onClick={handleBulkDelete}
                  disabled={deleteMutation.isPending}
                  className="px-3 py-1.5 bg-red-600 text-white rounded-md hover:bg-red-700 disabled:opacity-50 text-sm"
                >
                  Delete
                </button>
              </div>
            </div>
            <button
              onClick={() => setSelectedProducts([])}
              className="text-sm text-blue-600 hover:text-blue-800"
            >
              Clear Selection
            </button>
          </div>
        </div>
      )}

      {/* Search Bar */}
      <div className="mb-6">
        <input
          type="text"
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
          placeholder="Search products by name, SKU, identifier, or tag..."
          className="w-full max-w-md px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
        />
      </div>

      {filteredProducts.length === 0 ? (
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
              d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"
            />
          </svg>
          <h3 className="mt-4 text-lg font-medium text-gray-900">
            {searchQuery ? "No products found" : "No products yet"}
          </h3>
          <p className="mt-2 text-sm text-gray-500">
            {searchQuery
              ? "Try adjusting your search query"
              : "Create your first product to get started"}
          </p>
        </div>
      ) : (
        <div className="bg-white rounded-lg shadow overflow-hidden">
          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-6 py-3 text-left">
                    <input
                      type="checkbox"
                      checked={allSelected}
                      ref={(input) => {
                        if (input) input.indeterminate = someSelected;
                      }}
                      onChange={(e) => handleSelectAll(e.target.checked)}
                      className="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
                    />
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Product
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    SKU
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Price
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Stock
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Status
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Actions
                  </th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {filteredProducts.map((product) => (
                  <tr
                    key={product.id}
                    className={cn(
                      "hover:bg-gray-50",
                      selectedProducts.includes(product.id) && "bg-blue-50"
                    )}
                  >
                    <td className="px-6 py-4 whitespace-nowrap">
                      <input
                        type="checkbox"
                        checked={selectedProducts.includes(product.id)}
                        onChange={(e) =>
                          handleSelectProduct(product.id, e.target.checked)
                        }
                        className="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
                      />
                    </td>
                    <td className="px-6 py-4">
                      <div className="text-sm font-medium text-gray-900">
                        {product.name}
                      </div>
                      <div className="text-xs text-gray-500">
                        {product.identifier}
                      </div>
                      {product.tags.length > 0 && (
                        <div className="flex flex-wrap gap-1 mt-1">
                          {product.tags.slice(0, 3).map((tag) => (
                            <span
                              key={tag.id}
                              className="inline-flex items-center px-1.5 py-0.5 rounded text-xs font-medium bg-gray-100 text-gray-800"
                            >
                              {tag.name}
                            </span>
                          ))}
                          {product.tags.length > 3 && (
                            <span className="text-xs text-gray-500">
                              +{product.tags.length - 3}
                            </span>
                          )}
                        </div>
                      )}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      {product.sku || "-"}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      {product.price !== undefined
                        ? `$${product.price.toFixed(2)}`
                        : "-"}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      {product.stock !== undefined ? product.stock : "-"}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span
                        className={cn(
                          "px-2 py-1 text-xs font-medium rounded-full",
                          product.active
                            ? "bg-green-100 text-green-800"
                            : "bg-gray-100 text-gray-800"
                        )}
                      >
                        {product.active ? "Active" : "Inactive"}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm font-medium">
                      <div className="flex items-center gap-3">
                        <button
                          onClick={() => handleViewInventory(product)}
                          className="text-blue-600 hover:text-blue-900"
                          title="View Inventory"
                        >
                          📦
                        </button>
                        <button
                          onClick={() => handleCloneProduct(product.id)}
                          className="text-green-600 hover:text-green-900"
                          title="Clone Product"
                        >
                          📋
                        </button>
                        <Link
                          href={`/dashboard/products/${product.id}/edit`}
                          className="text-indigo-600 hover:text-indigo-900"
                          title="Edit Product"
                        >
                          ✏️
                        </Link>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* Inventory Side Panel */}
      {showInventory && (
        <SidePanel
          isOpen={!!showInventory}
          onClose={() => setShowInventory(null)}
          title="Product Inventory"
          width="lg"
        >
          <InventoryView
            productId={showInventory.productId}
            productName={showInventory.productName}
            onClose={() => setShowInventory(null)}
          />
        </SidePanel>
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
