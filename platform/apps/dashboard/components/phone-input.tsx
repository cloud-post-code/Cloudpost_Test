"use client";

import React, { useMemo } from "react";
import { UseFormRegisterReturn, FieldError, UseFormSetValue } from "react-hook-form";
import { parsePhoneNumber, AsYouType, CountryCode } from "libphonenumber-js";
import { cn } from "@/lib/utils";

// Country codes list - starting with +1 (US/Canada) and including common codes
const COUNTRY_CODES = [
  { code: "US", dialCode: "+1", name: "United States" },
  { code: "CA", dialCode: "+1", name: "Canada" },
  { code: "GB", dialCode: "+44", name: "United Kingdom" },
  { code: "AU", dialCode: "+61", name: "Australia" },
  { code: "DE", dialCode: "+49", name: "Germany" },
  { code: "FR", dialCode: "+33", name: "France" },
  { code: "IT", dialCode: "+39", name: "Italy" },
  { code: "ES", dialCode: "+34", name: "Spain" },
  { code: "NL", dialCode: "+31", name: "Netherlands" },
  { code: "BE", dialCode: "+32", name: "Belgium" },
  { code: "CH", dialCode: "+41", name: "Switzerland" },
  { code: "AT", dialCode: "+43", name: "Austria" },
  { code: "SE", dialCode: "+46", name: "Sweden" },
  { code: "NO", dialCode: "+47", name: "Norway" },
  { code: "DK", dialCode: "+45", name: "Denmark" },
  { code: "FI", dialCode: "+358", name: "Finland" },
  { code: "PL", dialCode: "+48", name: "Poland" },
  { code: "IE", dialCode: "+353", name: "Ireland" },
  { code: "PT", dialCode: "+351", name: "Portugal" },
  { code: "GR", dialCode: "+30", name: "Greece" },
  { code: "MX", dialCode: "+52", name: "Mexico" },
  { code: "BR", dialCode: "+55", name: "Brazil" },
  { code: "AR", dialCode: "+54", name: "Argentina" },
  { code: "CL", dialCode: "+56", name: "Chile" },
  { code: "CO", dialCode: "+57", name: "Colombia" },
  { code: "PE", dialCode: "+51", name: "Peru" },
  { code: "VE", dialCode: "+58", name: "Venezuela" },
  { code: "JP", dialCode: "+81", name: "Japan" },
  { code: "CN", dialCode: "+86", name: "China" },
  { code: "IN", dialCode: "+91", name: "India" },
  { code: "KR", dialCode: "+82", name: "South Korea" },
  { code: "SG", dialCode: "+65", name: "Singapore" },
  { code: "MY", dialCode: "+60", name: "Malaysia" },
  { code: "TH", dialCode: "+66", name: "Thailand" },
  { code: "ID", dialCode: "+62", name: "Indonesia" },
  { code: "PH", dialCode: "+63", name: "Philippines" },
  { code: "VN", dialCode: "+84", name: "Vietnam" },
  { code: "NZ", dialCode: "+64", name: "New Zealand" },
  { code: "ZA", dialCode: "+27", name: "South Africa" },
  { code: "EG", dialCode: "+20", name: "Egypt" },
  { code: "NG", dialCode: "+234", name: "Nigeria" },
  { code: "KE", dialCode: "+254", name: "Kenya" },
  { code: "AE", dialCode: "+971", name: "United Arab Emirates" },
  { code: "SA", dialCode: "+966", name: "Saudi Arabia" },
  { code: "IL", dialCode: "+972", name: "Israel" },
  { code: "TR", dialCode: "+90", name: "Turkey" },
  { code: "RU", dialCode: "+7", name: "Russia" },
];

interface PhoneInputProps {
  label: string;
  countryCodeName: string;
  phoneName: string;
  countryCodeRegister: UseFormRegisterReturn;
  phoneRegister: UseFormRegisterReturn;
  countryCodeError?: FieldError;
  phoneError?: FieldError;
  countryCodeValue?: string;
  phoneValue?: string;
  setValue?: UseFormSetValue<any>;
  required?: boolean;
  className?: string;
}

export function PhoneInput({
  label,
  countryCodeName,
  phoneName,
  countryCodeRegister,
  phoneRegister,
  countryCodeError,
  phoneError,
  countryCodeValue,
  phoneValue,
  setValue,
  required = false,
  className,
}: PhoneInputProps) {
  const [formattedPhone, setFormattedPhone] = React.useState("");

  // Initialize formatted phone when value changes
  React.useEffect(() => {
    if (phoneValue) {
      const countryCode = countryCodeValue || "+1";
      try {
        // Convert phoneValue to string and remove non-digits
        const phoneStr = String(phoneValue).replace(/\D/g, "");
        if (phoneStr) {
          const formatter = new AsYouType(countryCode.replace("+", "") as CountryCode);
          const formatted = formatter.input(phoneStr);
          setFormattedPhone(formatted);
        } else {
          setFormattedPhone("");
        }
      } catch {
        setFormattedPhone(String(phoneValue));
      }
    } else {
      setFormattedPhone("");
    }
  }, [phoneValue, countryCodeValue]);

  const handlePhoneChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const input = e.target.value;
    // Remove all non-digit characters
    const digitsOnly = input.replace(/\D/g, "");
    
    // Get the country code (default to +1)
    const countryCode = countryCodeValue || "+1";
    
    // Format the phone number as user types
    try {
      const formatter = new AsYouType(countryCode.replace("+", "") as CountryCode);
      const formatted = formatter.input(digitsOnly);
      setFormattedPhone(formatted);
      
      // Update form value with digits only (for storage)
      if (setValue) {
        setValue(phoneName, digitsOnly, { shouldValidate: true });
      }
      // Create synthetic event for react-hook-form
      const syntheticEvent = {
        ...e,
        target: { ...e.target, value: digitsOnly },
      };
      phoneRegister.onChange(syntheticEvent);
    } catch {
      setFormattedPhone(input);
      if (setValue) {
        setValue(phoneName, digitsOnly, { shouldValidate: true });
      }
      // Create synthetic event for react-hook-form
      const syntheticEvent = {
        ...e,
        target: { ...e.target, value: digitsOnly },
      };
      phoneRegister.onChange(syntheticEvent);
    }
  };

  const handleCountryCodeChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const newCountryCode = e.target.value;
    countryCodeRegister.onChange(e);
    
    if (setValue) {
      setValue(countryCodeName, newCountryCode, { shouldValidate: true });
    }
    
    // Re-format phone number with new country code
    if (phoneValue) {
      const digitsOnly = phoneValue.replace(/\D/g, "");
      try {
        const formatter = new AsYouType(newCountryCode.replace("+", "") as CountryCode);
        const formatted = formatter.input(digitsOnly);
        setFormattedPhone(formatted);
      } catch {
        setFormattedPhone(phoneValue);
      }
    }
  };

  return (
    <div className={className}>
      <label className="block text-sm font-medium text-gray-700 mb-2">
        {label} {required && <span className="text-red-500">*</span>}
      </label>
      <div className="grid grid-cols-2 gap-4">
        {/* Country Code Dropdown */}
        <div>
          <select
            {...countryCodeRegister}
            value={countryCodeValue || "+1"}
            onChange={(e) => {
              countryCodeRegister.onChange(e);
              handleCountryCodeChange(e);
            }}
            onBlur={countryCodeRegister.onBlur}
            className={cn(
              "w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500",
              countryCodeError && "border-red-500"
            )}
          >
            {COUNTRY_CODES.map((country) => (
              <option key={country.code} value={country.dialCode}>
                {country.dialCode} ({country.name})
              </option>
            ))}
          </select>
          {countryCodeError && (
            <p className="mt-1 text-sm text-red-500">{countryCodeError.message}</p>
          )}
        </div>

        {/* Phone Number Input */}
        <div>
          <input
            type="tel"
            {...phoneRegister}
            value={formattedPhone}
            onChange={(e) => {
              phoneRegister.onChange(e);
              handlePhoneChange(e);
            }}
            onBlur={phoneRegister.onBlur}
            placeholder="(123) 456-7890"
            className={cn(
              "w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500",
              phoneError && "border-red-500"
            )}
          />
          {phoneError && (
            <p className="mt-1 text-sm text-red-500">{phoneError.message}</p>
          )}
        </div>
      </div>
    </div>
  );
}

