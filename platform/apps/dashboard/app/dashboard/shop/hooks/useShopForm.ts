/**
 * Custom hook for shop form management
 * Handles form state, validation, and submission
 */

import React from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { getShop, updateShop, ShopData, UpdateShopRequest } from "../api/shopApi";

const pickupLocationSchema = z.object({
  id: z.number().optional(),
  countryId: z.number().optional(),
  stateId: z.number().optional(),
  city: z.string().optional(),
  address1: z.string().optional(),
  address2: z.string().optional(),
  postalCode: z.string().optional(),
  lat: z.string().optional(),
  lng: z.string().optional(),
  isActive: z.boolean().optional(),
});

const shopFormSchema = z.object({
  // General Info
  name: z.string().min(1, "Shop name is required"),
  url: z.string().optional(),
  phoneDcode: z.string().optional(),
  phone: z.string().optional(),
  // Address
  countryId: z.number().optional(),
  stateId: z.number().optional(),
  city: z.string().optional(),
  address1: z.string().optional(),
  address2: z.string().optional(),
  postalCode: z.string().optional(),
  returnAddressSame: z.boolean().default(true),
  returnAddress: z
    .object({
      countryId: z.number().optional(),
      stateId: z.number().optional(),
      city: z.string().optional(),
      address1: z.string().optional(),
      address2: z.string().optional(),
      postalCode: z.string().optional(),
    })
    .optional(),
  // Settings
  vacationStatus: z.boolean().default(false),
  returnEligibilityDays: z.number().min(0).optional(),
  cancellationEligibilityDays: z.number().min(0).optional(),
  fulfillmentMethod: z.number().default(1),
  // Shop Esthetic
  logo: z.string().optional(),
  banner: z.string().optional(),
  // Shop Info
  description: z.string().optional(),
  sellerInformation: z.string().optional(),
  paymentPolicy: z.string().optional(),
  shippingPolicy: z.string().optional(),
  refundPolicy: z.string().optional(),
  additionalInformation: z.string().optional(),
  // Pickup Locations
  pickupLocations: z.array(pickupLocationSchema).default([]),
});

export type ShopFormData = z.infer<typeof shopFormSchema>;

export function useShopForm(langId: number = 1) {
  const queryClient = useQueryClient();

  // Fetch shop data
  const { data: shopData, isLoading, error } = useQuery<ShopData>({
    queryKey: ["shop", langId],
    queryFn: () => getShop(langId),
  });

  // Initialize form
  const form = useForm<ShopFormData>({
    resolver: zodResolver(shopFormSchema),
    defaultValues: {
      name: "",
      url: "",
      phoneDcode: "",
      phone: "",
      returnAddressSame: true,
      vacationStatus: false,
      fulfillmentMethod: 1,
      pickupLocations: [],
    },
  });

  // Update form when data loads
  React.useEffect(() => {
    if (shopData) {
      form.reset({
        name: shopData.name || "",
        url: shopData.url || "",
        phoneDcode: shopData.phoneDcode || "",
        phone: shopData.phone || "",
        countryId: shopData.countryId,
        stateId: shopData.stateId,
        city: shopData.city || "",
        address1: shopData.address1 || "",
        address2: shopData.address2 || "",
        postalCode: shopData.postalCode || "",
        returnAddressSame: shopData.returnAddressSame ?? true,
        vacationStatus: shopData.vacationStatus ?? false,
        returnEligibilityDays: shopData.returnEligibilityDays,
        cancellationEligibilityDays: shopData.cancellationEligibilityDays,
        fulfillmentMethod: shopData.fulfillmentMethod ?? 1,
        logo: shopData.logo || "",
        banner: shopData.banner || "",
        description: shopData.description || "",
        sellerInformation: shopData.sellerInformation || "",
        paymentPolicy: shopData.paymentPolicy || "",
        shippingPolicy: shopData.shippingPolicy || "",
        refundPolicy: shopData.refundPolicy || "",
        additionalInformation: shopData.additionalInformation || "",
        pickupLocations: shopData.pickupLocations || [],
      });
    }
  }, [shopData, form]);

  // Update mutation
  const updateMutation = useMutation({
    mutationFn: (data: UpdateShopRequest) => updateShop(data, langId),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["shop", langId] });
    },
  });

  const onSubmit = async (data: ShopFormData) => {
    try {
      await updateMutation.mutateAsync(data);
    } catch (error) {
      console.error("Failed to update shop:", error);
      throw error;
    }
  };

  return {
    form,
    shopData,
    isLoading,
    error,
    onSubmit: form.handleSubmit(onSubmit),
    isSubmitting: updateMutation.isPending,
    updateMutation,
  };
}

