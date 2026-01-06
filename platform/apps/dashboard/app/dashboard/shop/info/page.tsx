"use client";

/**
 * Shop Info Page
 */

import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { useShopForm } from "../hooks/useShopForm";
import { cn } from "@/lib/utils";
import { PhoneInput } from "@/components/phone-input";

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

function ShopInfoPageContent() {
  const { form, isLoading, onSubmit } = useShopForm();
  const { register, handleSubmit, watch, setValue, formState: { errors } } = form;

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
          <PhoneInput
            label="Phone Number"
            countryCodeName="phoneDcode"
            phoneName="phone"
            countryCodeRegister={register("phoneDcode", { value: watch("phoneDcode") || "+1" })}
            phoneRegister={register("phone", { value: watch("phone") || "" })}
            countryCodeError={errors.phoneDcode}
            phoneError={errors.phone}
            countryCodeValue={watch("phoneDcode") || "+1"}
            phoneValue={watch("phone") || ""}
            setValue={setValue}
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

export default function ShopInfoPage() {
  return (
    <QueryClientProvider client={queryClient}>
      <ShopInfoPageContent />
    </QueryClientProvider>
  );
}

