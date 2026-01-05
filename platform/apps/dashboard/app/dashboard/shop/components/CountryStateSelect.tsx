/**
 * Country and State Select Components
 */

"use client";

import { Controller } from "react-hook-form";
import { Country, State } from "country-state-city";
import { cn } from "@/lib/utils";
import { useState, useEffect } from "react";

interface CountrySelectProps {
  control: any;
  name: string;
  errors: any;
  label: string;
  required?: boolean;
  defaultValue?: number | string;
  onCountryChange?: (countryCode: string | undefined) => void;
}

export function CountrySelect({
  control,
  name,
  errors,
  label,
  required = false,
  defaultValue,
  onCountryChange,
}: CountrySelectProps) {
  const countries = Country.getAllCountries();
  const [selectedCountryCode, setSelectedCountryCode] = useState<string>("US");

  // Set default to US if no value provided
  useEffect(() => {
    if (defaultValue) {
      // If defaultValue is a number (database ID), we'd need to map it
      // For now, assume it's an ISO code string or set to US
      if (typeof defaultValue === "string") {
        setSelectedCountryCode(defaultValue);
      }
    } else {
      setSelectedCountryCode("US");
    }
  }, [defaultValue]);

  return (
    <div>
      <label className="block text-sm font-medium text-gray-700 mb-2">
        {label} {required && <span className="text-red-500">*</span>}
      </label>
      <Controller
        name={name}
        control={control}
        defaultValue={selectedCountryCode}
        render={({ field }) => (
          <select
            value={selectedCountryCode}
            onChange={(e) => {
              const code = e.target.value || "US";
              setSelectedCountryCode(code);
              // Store the ISO code - in production, map to database ID
              field.onChange(code);
              if (onCountryChange) {
                onCountryChange(code);
              }
            }}
            className={cn(
              "w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500",
              errors[name] && "border-red-500"
            )}
          >
            {countries.map((country) => (
              <option key={country.isoCode} value={country.isoCode}>
                {country.name}
              </option>
            ))}
          </select>
        )}
      />
      {errors[name] && <p className="mt-1 text-sm text-red-500">{errors[name].message}</p>}
    </div>
  );
}

interface StateSelectProps {
  control: any;
  name: string;
  errors: any;
  label: string;
  countryCode?: string;
  required?: boolean;
  defaultValue?: number | string;
}

export function StateSelect({
  control,
  name,
  errors,
  label,
  countryCode,
  required = false,
  defaultValue,
}: StateSelectProps) {
  const states = countryCode ? State.getStatesOfCountry(countryCode) : [];

  return (
    <div>
      <label className="block text-sm font-medium text-gray-700 mb-2">
        {label} {required && <span className="text-red-500">*</span>}
      </label>
      <Controller
        name={name}
        control={control}
        defaultValue={defaultValue || ""}
        render={({ field }) => (
          <select
            {...field}
            value={field.value || ""}
            onChange={(e) => {
              const value = e.target.value || undefined;
              field.onChange(value);
            }}
            disabled={!countryCode || states.length === 0}
            className={cn(
              "w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500",
              errors[name] && "border-red-500",
              (!countryCode || states.length === 0) && "bg-gray-100 cursor-not-allowed"
            )}
          >
            <option value="">Select State</option>
            {states.map((state) => (
              <option key={state.isoCode} value={state.isoCode}>
                {state.name}
              </option>
            ))}
          </select>
        )}
      />
      {errors[name] && <p className="mt-1 text-sm text-red-500">{errors[name].message}</p>}
      {!countryCode && (
        <p className="mt-1 text-sm text-gray-500">Please select a country first</p>
      )}
    </div>
  );
}

