/**
 * Product API client functions
 * Handles all API calls related to product management
 */

const API_BASE_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:3001";

export interface ProductOption {
  id: number;
  identifier: string;
  name: string;
  type: number;
  values: ProductOptionValue[];
}

export interface ProductOptionValue {
  id: number;
  optionId: number;
  identifier: string;
  name: string;
  colorCode?: string;
}

export interface TaxStructure {
  id: number;
  identifier: string;
  name: string;
}

export interface ShippingProfile {
  id: number;
  identifier: string;
  name: string;
  isDefault: boolean;
}

export interface Tag {
  id: number;
  identifier: string;
  name: string;
}

export interface ProductCategory {
  id: number;
  identifier: string;
  name: string;
  parentId?: number;
  type?: string;
}

export interface CreateProductRequest {
  name: string;
  description?: string;
  shortDescription?: string;
  occasion?: string;
  categoryId?: number;
  images?: string[];
  taxStructureId?: number;
  weight?: number;
  weightUnit?: number;
  shippingProfileId?: number;
  fulfillmentType?: number;
  featured?: boolean;
  canBeCustom?: boolean;
  customPrompt?: string;
  tags?: string[];
  productOptions?: {
    optionId: number;
    optionValueIds: number[];
  }[];
}

export interface CreateInventoryItem {
  optionCombination: {
    optionId: number;
    optionValueId: number;
  }[];
  price: number;
  quantity: number;
  sku?: string;
}

export interface CreateInventoryRequest {
  productId: number;
  items: CreateInventoryItem[];
}

export async function getProductOptions(): Promise<ProductOption[]> {
  const response = await fetch(`${API_BASE_URL}/products/options`, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  });

  if (!response.ok) {
    throw new Error("Failed to fetch product options");
  }

  return response.json();
}

export interface CreateOptionRequest {
  name: string;
  type: number;
}

export interface CreateOptionValueRequest {
  optionId: number;
  name: string;
  colorCode?: string;
}

export async function createProductOption(data: CreateOptionRequest): Promise<ProductOption> {
  const response = await fetch(`${API_BASE_URL}/products/options`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(data),
  });

  if (!response.ok) {
    throw new Error("Failed to create product option");
  }

  return response.json();
}

export async function createOptionValue(data: CreateOptionValueRequest): Promise<ProductOptionValue> {
  const response = await fetch(`${API_BASE_URL}/products/options/values`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(data),
  });

  if (!response.ok) {
    throw new Error("Failed to create option value");
  }

  return response.json();
}

export async function getTaxStructures(): Promise<TaxStructure[]> {
  const response = await fetch(`${API_BASE_URL}/tax/structures`, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  });

  if (!response.ok) {
    throw new Error("Failed to fetch tax structures");
  }

  return response.json();
}

export async function getShippingProfiles(): Promise<ShippingProfile[]> {
  const response = await fetch(`${API_BASE_URL}/shipping/profiles`, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  });

  if (!response.ok) {
    throw new Error("Failed to fetch shipping profiles");
  }

  return response.json();
}

export async function getTags(): Promise<Tag[]> {
  const response = await fetch(`${API_BASE_URL}/tags`, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  });

  if (!response.ok) {
    throw new Error("Failed to fetch tags");
  }

  return response.json();
}

export async function getProductCategories(): Promise<ProductCategory[]> {
  const response = await fetch(`${API_BASE_URL}/products/categories`, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  });

  if (!response.ok) {
    throw new Error("Failed to fetch product categories");
  }

  return response.json();
}

export interface Occasion {
  value: string;
}

export async function getOccasions(): Promise<string[]> {
  const response = await fetch(`${API_BASE_URL}/products/occasions`, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  });

  if (!response.ok) {
    throw new Error("Failed to fetch occasions");
  }

  return response.json();
}

export async function createTag(name: string): Promise<Tag> {
  const response = await fetch(`${API_BASE_URL}/tags`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ name }),
  });

  if (!response.ok) {
    throw new Error("Failed to create tag");
  }

  return response.json();
}

export async function createProduct(data: CreateProductRequest): Promise<{ id: number }> {
  const response = await fetch(`${API_BASE_URL}/products`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(data),
  });

  if (!response.ok) {
    const error = await response.json().catch(() => ({ message: "Failed to create product" }));
    throw new Error(error.message || "Failed to create product");
  }

  return response.json();
}

export async function createInventory(data: CreateInventoryRequest): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/products/inventory`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(data),
  });

  if (!response.ok) {
    const error = await response.json().catch(() => ({ message: "Failed to create inventory" }));
    throw new Error(error.message || "Failed to create inventory");
  }
}

export interface InventoryItem {
  id: number;
  productId: number;
  productName?: string;
  sku?: string;
  price: number;
  quantity: number;
  optionCombination: {
    optionId: number;
    optionValueId: number;
    optionName?: string;
    optionValueName?: string;
  }[];
}

export interface ProductWithTags {
  id: number;
  identifier: string;
  name: string;
  tags: Tag[];
}

export interface ProductsResponse {
  data: ProductWithTags[];
  total: number;
}

export async function getInventories(): Promise<InventoryItem[]> {
  const response = await fetch(`${API_BASE_URL}/products/inventory`, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  });

  if (!response.ok) {
    throw new Error("Failed to fetch inventories");
  }

  return response.json();
}

export async function getProductsWithTags(): Promise<ProductsResponse> {
  const response = await fetch(`${API_BASE_URL}/products`, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  });

  if (!response.ok) {
    throw new Error("Failed to fetch products");
  }

  return response.json();
}

export async function updateProductTags(
  productId: number,
  tags: string[]
): Promise<{ success: boolean }> {
  const response = await fetch(`${API_BASE_URL}/products/${productId}/tags`, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ tags }),
  });

  if (!response.ok) {
    throw new Error("Failed to update product tags");
  }

  return response.json();
}

export interface ProductListItem {
  id: number;
  identifier: string;
  name: string;
  active: boolean;
  featured: boolean;
  sku?: string;
  price?: number;
  stock?: number;
  tags: Tag[];
}

export interface ProductListResponse {
  data: ProductListItem[];
  total: number;
}

export async function getProductList(): Promise<ProductListResponse> {
  const response = await fetch(`${API_BASE_URL}/products`, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  });

  if (!response.ok) {
    throw new Error("Failed to fetch products");
  }

  return response.json();
}

export async function activateProduct(productId: number): Promise<{ success: boolean }> {
  const response = await fetch(`${API_BASE_URL}/products/${productId}/activate`, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
    },
  });

  if (!response.ok) {
    throw new Error("Failed to activate product");
  }

  return response.json();
}

export async function deactivateProduct(productId: number): Promise<{ success: boolean }> {
  const response = await fetch(`${API_BASE_URL}/products/${productId}/deactivate`, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
    },
  });

  if (!response.ok) {
    throw new Error("Failed to deactivate product");
  }

  return response.json();
}

export async function bulkActivateProducts(productIds: number[]): Promise<{ success: boolean; count: number }> {
  const response = await fetch(`${API_BASE_URL}/products/bulk-activate`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ productIds }),
  });

  if (!response.ok) {
    throw new Error("Failed to activate products");
  }

  return response.json();
}

export async function bulkDeactivateProducts(productIds: number[]): Promise<{ success: boolean; count: number }> {
  const response = await fetch(`${API_BASE_URL}/products/bulk-deactivate`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ productIds }),
  });

  if (!response.ok) {
    throw new Error("Failed to deactivate products");
  }

  return response.json();
}

export async function bulkDeleteProducts(productIds: number[]): Promise<{ success: boolean; count: number }> {
  const response = await fetch(`${API_BASE_URL}/products/bulk-delete`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ productIds }),
  });

  if (!response.ok) {
    throw new Error("Failed to delete products");
  }

  return response.json();
}

export interface ProductCloneData {
  description?: string;
  shortDescription?: string;
  occasion?: string;
  categoryIds?: number[];
  tags?: string[];
  weight?: number;
  weightUnit?: number;
  canBeCustom?: boolean;
  customPrompt?: string;
  featured?: boolean;
  price?: number;
  costPrice?: number;
  stock?: number;
  minOrderQty?: number;
  trackInventory?: boolean;
  condition?: string;
}

export async function getProductForClone(productId: number): Promise<ProductCloneData> {
  const response = await fetch(`${API_BASE_URL}/products/${productId}/clone`, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  });

  if (!response.ok) {
    throw new Error("Failed to get product data for cloning");
  }

  return response.json();
}

export async function getProductInventory(productId: number): Promise<InventoryItem[]> {
  // Get all inventory and filter by productId on the frontend
  // In a real implementation, the backend should support filtering
  const response = await fetch(`${API_BASE_URL}/products/inventory`, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  });

  if (!response.ok) {
    throw new Error("Failed to fetch product inventory");
  }

  const allInventory: InventoryItem[] = await response.json();
  return allInventory.filter((item) => item.productId === productId);
}

