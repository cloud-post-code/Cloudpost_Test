"use client";

/**
 * Shop Info Pages (Policies and Information)
 */

import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { useShopForm } from "../hooks/useShopForm";
import { cn } from "@/lib/utils";

const queryClient = new QueryClient();

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

function ShopInfoPagesContent() {
  const { form, isLoading, onSubmit } = useShopForm();
  const { register, handleSubmit, formState: { errors } } = form;

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="text-gray-500">Loading shop data...</div>
      </div>
    );
  }

  return (
    <div className="max-w-4xl mx-auto">
      <h1 className="text-3xl font-bold mb-6">Shop Info</h1>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
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

export default function ShopInfoPagesPage() {
  return (
    <QueryClientProvider client={queryClient}>
      <ShopInfoPagesContent />
    </QueryClientProvider>
  );
}

