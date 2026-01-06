"use client";

/**
 * Shop Info, Address, and Settings Page
 * Combined page for shop information, address, and settings
 */

import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { useShopForm } from "../hooks/useShopForm";
import { cn } from "@/lib/utils";
import { PhoneInput } from "@/components/phone-input";
import { CountrySelect, StateSelect } from "../components/CountryStateSelect";
import { useState, useEffect } from "react";
import { Controller } from "react-hook-form";

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
  const { register, handleSubmit, watch, setValue, control, formState: { errors } } = form;
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
      <h1 className="text-3xl font-bold mb-6">Shop Info, Address & Settings</h1>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        {/* Shop Info Section */}
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
          <h2 className="text-xl font-semibold mb-4">Shop Information</h2>
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

        {/* Address Section */}
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
          <h2 className="text-xl font-semibold mb-4">Shop Address</h2>
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

        {/* Settings Section */}
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
          <h2 className="text-xl font-semibold mb-4">Shop Settings</h2>
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

export default function ShopInfoPage() {
  return (
    <QueryClientProvider client={queryClient}>
      <ShopInfoPageContent />
    </QueryClientProvider>
  );
}
