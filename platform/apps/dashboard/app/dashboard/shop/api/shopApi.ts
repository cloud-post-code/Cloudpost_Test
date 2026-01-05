/**
 * Shop API client functions
 * Handles all API calls related to shop management
 */

const API_BASE_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:3001";

export interface ShopData {
  id: number;
  userId: number;
  identifier: string;
  name: string;
  url?: string;
  phoneDcode?: string;
  phone?: string;
  countryId?: number;
  stateId?: number;
  city?: string;
  address1?: string;
  address2?: string;
  postalCode?: string;
  returnAddressSame: boolean;
  vacationStatus: boolean;
  returnEligibilityDays?: number;
  cancellationEligibilityDays?: number;
  fulfillmentMethod?: number;
  logo?: string;
  banner?: string;
  description?: string;
  sellerInformation?: string;
  paymentPolicy?: string;
  shippingPolicy?: string;
  refundPolicy?: string;
  additionalInformation?: string;
  pickupLocations: PickupLocation[];
  active: boolean;
  featured: boolean;
  createdAt: string;
  updatedAt: string;
}

export interface PickupLocation {
  id?: number;
  countryId?: number | string;
  stateId?: number | string;
  city?: string;
  address1?: string;
  address2?: string;
  postalCode?: string;
  lat?: string;
  lng?: string;
  isActive?: boolean;
}

export interface UpdateShopRequest {
  name?: string;
  url?: string;
  phoneDcode?: string;
  phone?: string;
  countryId?: number | string;
  stateId?: number | string;
  city?: string;
  address1?: string;
  address2?: string;
  postalCode?: string;
  returnAddressSame?: boolean;
  returnAddress?: {
    countryId?: number | string;
    stateId?: number | string;
    city?: string;
    address1?: string;
    address2?: string;
    postalCode?: string;
  };
  vacationStatus?: boolean;
  returnEligibilityDays?: number;
  cancellationEligibilityDays?: number;
  fulfillmentMethod?: number;
  logo?: string;
  banner?: string;
  langId?: number;
  description?: string;
  sellerInformation?: string;
  paymentPolicy?: string;
  shippingPolicy?: string;
  refundPolicy?: string;
  additionalInformation?: string;
  pickupLocations?: PickupLocation[];
}

export async function getShop(langId?: number): Promise<ShopData> {
  const url = new URL(`${API_BASE_URL}/shop`);
  if (langId) {
    url.searchParams.append("langId", langId.toString());
  }

  const response = await fetch(url.toString(), {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  });

  if (!response.ok) {
    throw new Error("Failed to fetch shop data");
  }

  return response.json();
}

export async function updateShop(data: UpdateShopRequest, langId?: number): Promise<ShopData> {
  const url = new URL(`${API_BASE_URL}/shop`);
  if (langId) {
    url.searchParams.append("langId", langId.toString());
  }

  const response = await fetch(url.toString(), {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(data),
  });

  if (!response.ok) {
    const error = await response.json().catch(() => ({ message: "Failed to update shop" }));
    throw new Error(error.message || "Failed to update shop");
  }

  return response.json();
}

