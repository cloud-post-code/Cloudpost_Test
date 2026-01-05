"use client";

/**
 * Shop Settings Page
 */

import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { useShopForm } from "../hooks/useShopForm";
import { Controller } from "react-hook-form";
import { cn } from "@/lib/utils";

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

function ShopSettingsPageContent() {
  const { form, isLoading, onSubmit } = useShopForm();
  const { register, handleSubmit, control, formState: { errors } } = form;

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="text-gray-500">Loading shop data...</div>
      </div>
    );
  }

  return (
    <div className="max-w-4xl mx-auto">
      <h1 className="text-3xl font-bold mb-6">Shop Settings</h1>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
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
              <label className="flex items-center">
                <input
                  type="radio"
                  value={3}
                  {...register("fulfillmentMethod")}
                  className="mr-2 h-4 w-4 text-blue-600 focus:ring-blue-500"
                />
                <span className="text-sm text-gray-700">Shipping & Pickup</span>
              </label>
            </div>
          </div>
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

export default function ShopSettingsPage() {
  return (
    <QueryClientProvider client={queryClient}>
      <ShopSettingsPageContent />
    </QueryClientProvider>
  );
}

