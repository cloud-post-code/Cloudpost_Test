"use client";

/**
 * Shop Management Page
 * Comprehensive single-page form with organized sections for all shop settings
 */

import React, { useState } from "react";
import { useForm, Controller } from "react-hook-form";
import { useQuery, useMutation, useQueryClient, QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { getShop, updateShop, ShopData, UpdateShopRequest } from "./api/shopApi";
import { cn } from "@/lib/utils";

// Create a query client instance
const queryClient = new QueryClient();

// Section Component Wrapper
function Section({
  title,
  children,
  isOpen = true,
  onToggle,
}: {
  title: string;
  children: React.ReactNode;
  isOpen?: boolean;
  onToggle?: () => void;
}) {
  return (
    <div className="bg-white rounded-lg shadow mb-6">
      <button
        type="button"
        onClick={onToggle}
        className="w-full px-6 py-4 flex items-center justify-between text-left border-b border-gray-200 hover:bg-gray-50"
      >
        <h2 className="text-xl font-semibold text-gray-900">{title}</h2>
        <span className="text-gray-500">{isOpen ? "−" : "+"}</span>
      </button>
      {isOpen && <div className="p-6 space-y-4">{children}</div>}
    </div>
  );
}

// Form Input Component
function FormInput({
  label,
  name,
  register,
  errors,
  type = "text",
  placeholder,
  required = false,
  className,
}: {
  label: string;
  name: string;
  register: any;
  errors: any;
  type?: string;
  placeholder?: string;
  required?: boolean;
  className?: string;
}) {
  return (
    <div className={className}>
      <label className="block text-sm font-medium text-gray-700 mb-2">
        {label} {required && <span className="text-red-500">*</span>}
      </label>
      <input
        type={type}
        {...register(name, { required: required ? `${label} is required` : false })}
        placeholder={placeholder}
        className={cn(
          "w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500",
          errors[name] && "border-red-500"
        )}
      />
      {errors[name] && <p className="mt-1 text-sm text-red-500">{errors[name].message}</p>}
    </div>
  );
}

function FormTextarea({
  label,
  name,
  register,
  errors,
  placeholder,
  required = false,
  rows = 4,
  className,
}: {
  label: string;
  name: string;
  register: any;
  errors: any;
  placeholder?: string;
  required?: boolean;
  rows?: number;
  className?: string;
}) {
  return (
    <div className={className}>
      <label className="block text-sm font-medium text-gray-700 mb-2">
        {label} {required && <span className="text-red-500">*</span>}
      </label>
      <textarea
        {...register(name, { required: required ? `${label} is required` : false })}
        placeholder={placeholder}
        rows={rows}
        className={cn(
          "w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500",
          errors[name] && "border-red-500"
        )}
      />
      {errors[name] && <p className="mt-1 text-sm text-red-500">{errors[name].message}</p>}
    </div>
  );
}

function ShopPageContent() {
  const queryClient = useQueryClient();
  const [openSections, setOpenSections] = useState<Record<string, boolean>>({
    general: true,
    address: true,
    settings: true,
    esthetic: true,
    info: true,
    pickup: true,
  });

  const toggleSection = (section: string) => {
    setOpenSections((prev) => ({ ...prev, [section]: !prev[section] }));
  };

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
      alert("Shop updated successfully!");
    },
    onError: (error: Error) => {
      alert(`Failed to update shop: ${error.message}`);
    },
  });

  const {
    register,
    handleSubmit,
    control,
    watch,
    formState: { errors },
    reset,
  } = useForm<UpdateShopRequest>({
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

  // Reset form when data loads
  React.useEffect(() => {
    if (shopData) {
      reset({
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
  }, [shopData, reset]);

  const returnAddressSame = watch("returnAddressSame");
  const onSubmit = (data: UpdateShopRequest) => {
    updateMutation.mutate(data);
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="text-gray-500">Loading shop data...</div>
      </div>
    );
  }

  return (
    <div className="max-w-4xl mx-auto">
      <h1 className="text-3xl font-bold mb-6">Shop Management</h1>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        {/* Section 1: General Info */}
        <Section
          title="Info"
          isOpen={openSections.general}
          onToggle={() => toggleSection("general")}
        >
          <FormInput
            label="Shop Name"
            name="name"
            register={register}
            errors={errors}
            placeholder="Enter shop name"
            required
          />
          <FormInput
            label="Shop URL"
            name="url"
            register={register}
            errors={errors}
            placeholder="shop-url"
          />
          <div className="grid grid-cols-2 gap-4">
            <FormInput
              label="Phone Country Code"
              name="phoneDcode"
              register={register}
              errors={errors}
              placeholder="+1"
            />
            <FormInput
              label="Phone Number"
              name="phone"
              register={register}
              errors={errors}
              type="tel"
              placeholder="1234567890"
            />
          </div>
        </Section>

        {/* Section 2: Address */}
        <Section
          title="Address"
          isOpen={openSections.address}
          onToggle={() => toggleSection("address")}
        >
          <div className="grid grid-cols-2 gap-4">
            <FormInput label="Country" name="countryId" register={register} errors={errors} type="number" />
            <FormInput label="State" name="stateId" register={register} errors={errors} type="number" />
          </div>
          <FormInput label="Postal Code" name="postalCode" register={register} errors={errors} />
          <FormInput label="Address Line 1" name="address1" register={register} errors={errors} />
          <FormInput label="Address Line 2" name="address2" register={register} errors={errors} />
          <FormInput label="City" name="city" register={register} errors={errors} />

          <div className="flex items-center">
            <input
              type="checkbox"
              {...register("returnAddressSame")}
              className="mr-2 h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
            />
            <label className="text-sm font-medium text-gray-700">Return Address is Same</label>
          </div>

          {!returnAddressSame && (
            <div className="mt-4 p-4 bg-gray-50 rounded-md space-y-4">
              <h3 className="font-medium text-gray-900 mb-2">Return Address</h3>
              <div className="grid grid-cols-2 gap-4">
                <FormInput
                  label="Country"
                  name="returnAddress.countryId"
                  register={register}
                  errors={errors}
                  type="number"
                />
                <FormInput
                  label="State"
                  name="returnAddress.stateId"
                  register={register}
                  errors={errors}
                  type="number"
                />
              </div>
              <FormInput
                label="Postal Code"
                name="returnAddress.postalCode"
                register={register}
                errors={errors}
              />
              <FormInput
                label="Address"
                name="returnAddress.address1"
                register={register}
                errors={errors}
              />
              <FormInput label="City" name="returnAddress.city" register={register} errors={errors} />
            </div>
          )}
        </Section>

        {/* Section 3: Settings */}
        <Section
          title="Settings"
          isOpen={openSections.settings}
          onToggle={() => toggleSection("settings")}
        >
          <div className="flex items-center">
            <Controller
              name="vacationStatus"
              control={control}
              render={({ field: { value, onChange, onBlur, name, ref } }) => (
                <label className="flex items-center cursor-pointer">
                  <input
                    type="checkbox"
                    name={name}
                    ref={ref}
                    checked={value || false}
                    onChange={(e) => onChange(e.target.checked)}
                    onBlur={onBlur}
                    className="mr-2 h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
                  />
                  <span className="text-sm font-medium text-gray-700">Vacation Status</span>
                </label>
              )}
            />
          </div>
          <div className="grid grid-cols-2 gap-4">
            <FormInput
              label="Return Eligibility (days)"
              name="returnEligibilityDays"
              register={register}
              errors={errors}
              type="number"
            />
            <FormInput
              label="Cancellation Eligibility (days)"
              name="cancellationEligibilityDays"
              register={register}
              errors={errors}
              type="number"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">Fulfillment Method</label>
            <div className="space-y-2">
              <label className="flex items-center">
                <input
                  type="radio"
                  value={1}
                  {...register("fulfillmentMethod")}
                  className="mr-2 h-4 w-4 text-blue-600 focus:ring-blue-500"
                />
                <span className="text-sm text-gray-700">Shipping</span>
              </label>
              <label className="flex items-center">
                <input
                  type="radio"
                  value={2}
                  {...register("fulfillmentMethod")}
                  className="mr-2 h-4 w-4 text-blue-600 focus:ring-blue-500"
                />
                <span className="text-sm text-gray-700">Pickup</span>
              </label>
            </div>
          </div>
        </Section>

        {/* Section 4: Shop Esthetic */}
        <Section
          title="Shop Esthetic"
          isOpen={openSections.esthetic}
          onToggle={() => toggleSection("esthetic")}
        >
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">Logo</label>
            <input
              type="file"
              accept="image/*"
              className="w-full px-3 py-2 border border-gray-300 rounded-md"
              onChange={(e) => {
                // TODO: Handle file upload
                const file = e.target.files?.[0];
                if (file) {
                  // For now, just update the form value with a placeholder
                  // In production, upload to storage and update with URL
                }
              }}
            />
            {watch("logo") && (
              <p className="mt-2 text-sm text-gray-500">Current logo: {watch("logo")}</p>
            )}
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">Banner</label>
            <input
              type="file"
              accept="image/*"
              className="w-full px-3 py-2 border border-gray-300 rounded-md"
              onChange={(e) => {
                // TODO: Handle file upload
                const file = e.target.files?.[0];
                if (file) {
                  // For now, just update the form value with a placeholder
                  // In production, upload to storage and update with URL
                }
              }}
            />
            {watch("banner") && (
              <p className="mt-2 text-sm text-gray-500">Current banner: {watch("banner")}</p>
            )}
          </div>
        </Section>

        {/* Section 5: Shop Info */}
        <Section
          title="Shop Info"
          isOpen={openSections.info}
          onToggle={() => toggleSection("info")}
        >
          <FormTextarea
            label="Seller Information"
            name="sellerInformation"
            register={register}
            errors={errors}
            placeholder="Enter seller information"
          />
          <FormTextarea
            label="Shop Description"
            name="description"
            register={register}
            errors={errors}
            placeholder="Enter shop description"
          />
          <FormTextarea
            label="Payment Policy"
            name="paymentPolicy"
            register={register}
            errors={errors}
            placeholder="Enter payment policy"
          />
          <FormTextarea
            label="Shipping Structure & Policy"
            name="shippingPolicy"
            register={register}
            errors={errors}
            placeholder="Enter shipping policy"
          />
          <FormTextarea
            label="Refund Policy"
            name="refundPolicy"
            register={register}
            errors={errors}
            placeholder="Enter refund policy"
          />
          <FormTextarea
            label="Additional Information"
            name="additionalInformation"
            register={register}
            errors={errors}
            placeholder="Enter additional information"
          />
        </Section>

        {/* Section 6: Pickup Locations */}
        <Section
          title="Pickup Locations"
          isOpen={openSections.pickup}
          onToggle={() => toggleSection("pickup")}
        >
          <Controller
            name="pickupLocations"
            control={control}
            render={({ field }) => (
              <div className="space-y-4">
                {field.value?.map((location, index) => (
                  <div key={location.id || index} className="p-4 border border-gray-200 rounded-md space-y-4">
                    <div className="flex justify-between items-center mb-2">
                      <h4 className="font-medium text-gray-900">Location {index + 1}</h4>
                      <button
                        type="button"
                        onClick={() => {
                          const newLocations = field.value?.filter((_, i) => i !== index) || [];
                          field.onChange(newLocations);
                        }}
                        className="text-red-600 hover:text-red-800 text-sm"
                      >
                        Remove
                      </button>
                    </div>
                    <div className="grid grid-cols-2 gap-4">
                      <input
                        type="number"
                        placeholder="Country ID"
                        value={location.countryId || ""}
                        onChange={(e) => {
                          const newLocations = [...(field.value || [])];
                          newLocations[index] = { ...location, countryId: Number(e.target.value) || undefined };
                          field.onChange(newLocations);
                        }}
                        className="px-3 py-2 border border-gray-300 rounded-md"
                      />
                      <input
                        type="number"
                        placeholder="State ID"
                        value={location.stateId || ""}
                        onChange={(e) => {
                          const newLocations = [...(field.value || [])];
                          newLocations[index] = { ...location, stateId: Number(e.target.value) || undefined };
                          field.onChange(newLocations);
                        }}
                        className="px-3 py-2 border border-gray-300 rounded-md"
                      />
                    </div>
                    <input
                      type="text"
                      placeholder="Postal Code"
                      value={location.postalCode || ""}
                      onChange={(e) => {
                        const newLocations = [...(field.value || [])];
                        newLocations[index] = { ...location, postalCode: e.target.value };
                        field.onChange(newLocations);
                      }}
                      className="w-full px-3 py-2 border border-gray-300 rounded-md"
                    />
                    <input
                      type="text"
                      placeholder="Address"
                      value={location.address1 || ""}
                      onChange={(e) => {
                        const newLocations = [...(field.value || [])];
                        newLocations[index] = { ...location, address1: e.target.value };
                        field.onChange(newLocations);
                      }}
                      className="w-full px-3 py-2 border border-gray-300 rounded-md"
                    />
                    <input
                      type="text"
                      placeholder="City"
                      value={location.city || ""}
                      onChange={(e) => {
                        const newLocations = [...(field.value || [])];
                        newLocations[index] = { ...location, city: e.target.value };
                        field.onChange(newLocations);
                      }}
                      className="w-full px-3 py-2 border border-gray-300 rounded-md"
                    />
                  </div>
                ))}
                <button
                  type="button"
                  onClick={() => {
                    const newLocations = [...(field.value || []), {}];
                    field.onChange(newLocations);
                  }}
                  className="w-full px-4 py-2 border-2 border-dashed border-gray-300 rounded-md text-gray-600 hover:border-gray-400 hover:text-gray-800"
                >
                  + Add Pickup Location
                </button>
              </div>
            )}
          />
        </Section>

        {/* Submit Button */}
        <div className="flex justify-end space-x-4 pt-4 border-t border-gray-200">
          <button
            type="button"
            onClick={() => reset()}
            className="px-6 py-2 border border-gray-300 rounded-md text-gray-700 hover:bg-gray-50"
          >
            Reset
          </button>
          <button
            type="submit"
            disabled={updateMutation.isPending}
            className="px-6 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {updateMutation.isPending ? "Saving..." : "Save Changes"}
          </button>
        </div>
      </form>
    </div>
  );
}

export default function ShopPage() {
  return (
    <QueryClientProvider client={queryClient}>
      <ShopPageContent />
    </QueryClientProvider>
  );
}
