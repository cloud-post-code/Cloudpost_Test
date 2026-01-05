"use client";

/**
 * Pickup Locations Page
 */

import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { useShopForm } from "../hooks/useShopForm";
import { useForm, Controller } from "react-hook-form";
import { UpdateShopRequest, PickupLocation } from "../api/shopApi";
import { cn } from "@/lib/utils";
import { CountrySelect, StateSelect } from "../components/CountryStateSelect";
import { useState } from "react";

const queryClient = new QueryClient();

function ShopPickupPageContent() {
  const { form, shopData, isLoading, onSubmit } = useShopForm();
  const { register, handleSubmit, control, formState: { errors } } = form;
  const [countryCodes, setCountryCodes] = useState<Record<number, string>>({});

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="text-gray-500">Loading shop data...</div>
      </div>
    );
  }

  return (
    <div className="max-w-4xl mx-auto">
      <h1 className="text-3xl font-bold mb-6">Pickup Locations</h1>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
          <Controller
            name="pickupLocations"
            control={control}
            render={({ field }) => (
              <div className="space-y-4">
                {field.value?.map((location, index) => {
                  const locationKey = location.id || index;
                  const countryCode = countryCodes[locationKey] || "US";
                  
                  return (
                    <div key={locationKey} className="p-4 border border-gray-200 rounded-md space-y-4">
                      <div className="flex justify-between items-center mb-2">
                        <h4 className="font-medium text-gray-900">Location {index + 1}</h4>
                        <button
                          type="button"
                          onClick={() => {
                            const newLocations = field.value?.filter((_, i) => i !== index) || [];
                            field.onChange(newLocations);
                            const newCountryCodes = { ...countryCodes };
                            delete newCountryCodes[locationKey];
                            setCountryCodes(newCountryCodes);
                          }}
                          className="text-red-600 hover:text-red-800 text-sm"
                        >
                          Remove
                        </button>
                      </div>
                      <div className="grid grid-cols-2 gap-4">
                        <CountrySelect
                          control={control}
                          name={`pickupLocations.${index}.countryId`}
                          errors={errors}
                          label="Country"
                          onCountryChange={(code) => {
                            setCountryCodes({ ...countryCodes, [locationKey]: code || "US" });
                          }}
                        />
                        <StateSelect
                          control={control}
                          name={`pickupLocations.${index}.stateId`}
                          errors={errors}
                          label="State"
                          countryCode={countryCode}
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
                  );
                })}
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
        </div>

        <div className="flex justify-end space-x-4 pt-4">
          <button
            type="submit"
            className="px-6 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700"
          >
            Save Changes
          </button>
        </div>
      </form>
    </div>
  );
}

export default function ShopPickupPage() {
  return (
    <QueryClientProvider client={queryClient}>
      <ShopPickupPageContent />
    </QueryClientProvider>
  );
}

