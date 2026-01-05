"use client";

/**
 * Shop Address Page
 */

import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { useShopForm } from "../hooks/useShopForm";
import { cn } from "@/lib/utils";
import { CountrySelect, StateSelect } from "../components/CountryStateSelect";
import { useState, useEffect } from "react";

const queryClient = new QueryClient();

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

function ShopAddressPageContent() {
  const { form, isLoading, onSubmit } = useShopForm();
  const { register, handleSubmit, control, watch, formState: { errors } } = form;
  const [countryCode, setCountryCode] = useState<string>("US");
  const [returnCountryCode, setReturnCountryCode] = useState<string>("US");
  const returnAddressSame = watch("returnAddressSame");

  // Reset state when country changes
  useEffect(() => {
    if (countryCode) {
      form.setValue("stateId", undefined);
    }
  }, [countryCode, form]);

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="text-gray-500">Loading shop data...</div>
      </div>
    );
  }

  return (
    <div className="max-w-4xl mx-auto">
      <h1 className="text-3xl font-bold mb-6">Shop Address</h1>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
          <div className="grid grid-cols-2 gap-4">
            <CountrySelect
              control={control}
              name="countryId"
              errors={errors}
              label="Country"
              onCountryChange={(code) => setCountryCode(code || "US")}
            />
            <StateSelect
              control={control}
              name="stateId"
              errors={errors}
              label="State"
              countryCode={countryCode}
            />
          </div>
          <FormInput label="Postal Code" name="postalCode" register={register} errors={errors} />
          <FormInput label="Address Line 1" name="address1" register={register} errors={errors} />
          <FormInput label="Address Line 2" name="address2" register={register} errors={errors} />
          <FormInput label="City" name="city" register={register} errors={errors} />

          <div className="flex items-center pt-4 border-t border-gray-200">
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
                <CountrySelect
                  control={control}
                  name="returnAddress.countryId"
                  errors={errors}
                  label="Country"
                  onCountryChange={(code) => setReturnCountryCode(code || "US")}
                />
                <StateSelect
                  control={control}
                  name="returnAddress.stateId"
                  errors={errors}
                  label="State"
                  countryCode={returnCountryCode}
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

export default function ShopAddressPage() {
  return (
    <QueryClientProvider client={queryClient}>
      <ShopAddressPageContent />
    </QueryClientProvider>
  );
}

