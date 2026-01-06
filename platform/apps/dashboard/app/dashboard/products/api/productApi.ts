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

