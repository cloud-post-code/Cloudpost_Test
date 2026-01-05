/**
 * Common types used across the platform
 */

export type UserRole = "buyer" | "seller" | "affiliate" | "advertiser" | "admin";

export interface BaseEntity {
  id: number;
  createdAt: Date;
  updatedAt: Date;
}

export interface PaginationParams {
  page?: number;
  pageSize?: number;
}

export interface PaginatedResponse<T> {
  data: T[];
  total: number;
  page: number;
  pageSize: number;
  totalPages: number;
}

