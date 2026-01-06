/**
 * Shared hook for shop form management
 */

import { useForm } from "react-hook-form";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { getShop, updateShop, ShopData, UpdateShopRequest } from "../api/shopApi";
import { useEffect } from "react";

export function useShopForm() {
  const queryClient = useQueryClient();

  // Fetch shop data
  const { data: shopData, isLoading } = useQuery<ShopData>({
    queryKey: ["shop", 1],
    queryFn: () => getShop(1),
  });

  // Update mutation
  const updateMutation = useMutation({
    mutationFn: (data: UpdateShopRequest) => updateShop(data, 1),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["shop", 1] });
    },
    onError: (error: Error) => {
      console.error("Failed to update shop:", error);
    },
  });

  const form = useForm<UpdateShopRequest>({
    defaultValues: {
      name: "",
      url: "",
      phoneDcode: "+1",
      phone: "",
      returnAddressSame: true,
      vacationStatus: false,
      fulfillmentMethod: 1,
      pickupLocations: [],
    },
  });

  // Reset form when data loads
  useEffect(() => {
    if (shopData) {
      form.reset({
        name: shopData.name || "",
        url: shopData.url || "",
        phoneDcode: shopData.phoneDcode || "+1",
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

  const onSubmit = (data: UpdateShopRequest) => {
    updateMutation.mutate(data, {
      onSuccess: () => {
        alert("Shop updated successfully!");
      },
      onError: (error: Error) => {
        alert(`Failed to update shop: ${error.message}`);
      },
    });
  };

  return {
    form,
    shopData,
    isLoading,
    updateMutation,
    onSubmit,
  };
}
