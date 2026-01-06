"use client";

/**
 * Tags Management Page
 * Manage product tags - view all products and their tags, add new tags
 */

import { useState } from "react";
import { useQuery, useMutation, useQueryClient, QueryClient, QueryClientProvider } from "@tanstack/react-query";
import {
  getProductsWithTags,
  updateProductTags,
  getTags,
  createTag,
  ProductWithTags,
  Tag,
} from "../../../api/productApi";
import { cn } from "@/lib/utils";

const queryClient = new QueryClient();

interface TagInputProps {
  product: ProductWithTags;
  onSave: (productId: number, tags: string[]) => void;
  allTags: Tag[];
}

function ProductTagRow({ product, onSave, allTags }: TagInputProps) {
  const [isEditing, setIsEditing] = useState(false);
  const [tagInput, setTagInput] = useState("");
  const [currentTags, setCurrentTags] = useState<string[]>(
    product.tags.map((t) => t.name)
  );

  const handleAddTag = () => {
    const trimmedTag = tagInput.trim();
    if (trimmedTag && !currentTags.includes(trimmedTag)) {
      setCurrentTags([...currentTags, trimmedTag]);
      setTagInput("");
    }
  };

  const handleRemoveTag = (tagToRemove: string) => {
    setCurrentTags(currentTags.filter((tag) => tag !== tagToRemove));
  };

  const handleKeyPress = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === "Enter") {
      e.preventDefault();
      handleAddTag();
    }
  };

  const handleSave = () => {
    onSave(product.id, currentTags);
    setIsEditing(false);
  };

  const handleCancel = () => {
    setCurrentTags(product.tags.map((t) => t.name));
    setTagInput("");
    setIsEditing(false);
  };

  const handleTagSuggestion = (tagName: string) => {
    if (!currentTags.includes(tagName)) {
      setCurrentTags([...currentTags, tagName]);
    }
  };

  return (
    <tr className="border-b border-gray-200 hover:bg-gray-50">
      <td className="px-6 py-4 whitespace-nowrap">
        <div className="text-sm font-medium text-gray-900">{product.name}</div>
        <div className="text-xs text-gray-500">{product.identifier}</div>
      </td>
      <td className="px-6 py-4">
        {isEditing ? (
          <div className="space-y-2">
            {/* Current Tags */}
            <div className="flex flex-wrap gap-2 mb-2">
              {currentTags.map((tag, index) => (
                <span
                  key={index}
                  className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800"
                >
                  {tag}
                  <button
                    onClick={() => handleRemoveTag(tag)}
                    className="ml-1.5 inline-flex items-center justify-center w-4 h-4 rounded-full hover:bg-blue-200"
                  >
                    <svg
                      className="w-3 h-3"
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
                </span>
              ))}
            </div>

            {/* Tag Input */}
            <div className="flex gap-2">
              <input
                type="text"
                value={tagInput}
                onChange={(e) => setTagInput(e.target.value)}
                onKeyPress={handleKeyPress}
                placeholder="Enter tag name and press Enter"
                className="flex-1 px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm"
              />
              <button
                onClick={handleAddTag}
                className="px-3 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 text-sm"
              >
                Add
              </button>
            </div>

            {/* Tag Suggestions */}
            {allTags.length > 0 && (
              <div className="mt-2">
                <p className="text-xs text-gray-500 mb-1">Suggestions:</p>
                <div className="flex flex-wrap gap-1">
                  {allTags
                    .filter((tag) => !currentTags.includes(tag.name))
                    .slice(0, 10)
                    .map((tag) => (
                      <button
                        key={tag.id}
                        onClick={() => handleTagSuggestion(tag.name)}
                        className="px-2 py-1 text-xs bg-gray-100 text-gray-700 rounded hover:bg-gray-200"
                      >
                        + {tag.name}
                      </button>
                    ))}
                </div>
              </div>
            )}

            {/* Action Buttons */}
            <div className="flex gap-2 mt-3">
              <button
                onClick={handleSave}
                className="px-3 py-1.5 bg-blue-600 text-white rounded-md hover:bg-blue-700 text-sm"
              >
                Save
              </button>
              <button
                onClick={handleCancel}
                className="px-3 py-1.5 border border-gray-300 text-gray-700 rounded-md hover:bg-gray-50 text-sm"
              >
                Cancel
              </button>
            </div>
          </div>
        ) : (
          <div className="space-y-2">
            <div className="flex flex-wrap gap-2">
              {product.tags.length > 0 ? (
                product.tags.map((tag) => (
                  <span
                    key={tag.id}
                    className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800"
                  >
                    {tag.name}
                  </span>
                ))
              ) : (
                <span className="text-sm text-gray-400">No tags</span>
              )}
            </div>
            <button
              onClick={() => setIsEditing(true)}
              className="text-xs text-blue-600 hover:text-blue-800 font-medium"
            >
              Edit Tags
            </button>
          </div>
        )}
      </td>
    </tr>
  );
}

function TagsPageContent() {
  const queryClient = useQueryClient();
  const [searchQuery, setSearchQuery] = useState("");

  // Fetch products with tags
  const { data: productsData, isLoading: isLoadingProducts } = useQuery({
    queryKey: ["productsWithTags"],
    queryFn: getProductsWithTags,
  });

  // Fetch all available tags for suggestions
  const { data: allTags = [] } = useQuery({
    queryKey: ["tags"],
    queryFn: getTags,
  });

  // Mutation for updating product tags
  const updateTagsMutation = useMutation({
    mutationFn: ({ productId, tags }: { productId: number; tags: string[] }) =>
      updateProductTags(productId, tags),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["productsWithTags"] });
      queryClient.invalidateQueries({ queryKey: ["tags"] });
    },
  });

  const handleSaveTags = async (productId: number, tags: string[]) => {
    try {
      await updateTagsMutation.mutateAsync({ productId, tags });
    } catch (error) {
      console.error("Failed to update tags:", error);
      alert("Failed to update tags. Please try again.");
    }
  };

  // Filter products based on search query
  const filteredProducts =
    productsData?.data.filter(
      (product) =>
        product.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
        product.identifier.toLowerCase().includes(searchQuery.toLowerCase()) ||
        product.tags.some((tag) =>
          tag.name.toLowerCase().includes(searchQuery.toLowerCase())
        )
    ) || [];

  if (isLoadingProducts) {
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
          <h1 className="text-3xl font-bold">Product Tags</h1>
          <p className="text-gray-500 mt-1">
            Manage tags for all your products. Click "Edit Tags" to add or remove tags.
          </p>
        </div>
      </div>

      {/* Search Bar */}
      <div className="mb-6">
        <input
          type="text"
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
          placeholder="Search products by name, identifier, or tag..."
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
              d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"
            />
          </svg>
          <h3 className="mt-4 text-lg font-medium text-gray-900">
            {searchQuery ? "No products found" : "No products yet"}
          </h3>
          <p className="mt-2 text-sm text-gray-500">
            {searchQuery
              ? "Try adjusting your search query"
              : "Create your first product to start adding tags"}
          </p>
        </div>
      ) : (
        <div className="bg-white rounded-lg shadow overflow-hidden">
          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Product
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Tags
                  </th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {filteredProducts.map((product) => (
                  <ProductTagRow
                    key={product.id}
                    product={product}
                    onSave={handleSaveTags}
                    allTags={allTags}
                  />
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {updateTagsMutation.isPending && (
        <div className="fixed bottom-4 right-4 bg-blue-600 text-white px-4 py-2 rounded-md shadow-lg">
          Saving tags...
        </div>
      )}
    </div>
  );
}

export default function TagsPage() {
  return (
    <QueryClientProvider client={queryClient}>
      <TagsPageContent />
    </QueryClientProvider>
  );
}
