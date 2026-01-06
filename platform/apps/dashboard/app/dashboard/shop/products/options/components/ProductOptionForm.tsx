"use client";

import React, { useState } from "react";
import { useForm } from "react-hook-form";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import {
  createProductOption,
  createOptionValue,
  CreateOptionRequest,
  ProductOption,
} from "../../../../products/api/productApi";
import { cn } from "@/lib/utils";

interface OptionValue {
  id: string;
  name: string;
  colorCode?: string;
}

interface ProductOptionFormData {
  optionName: string;
  optionType: number;
}

interface ProductOptionFormProps {
  onSuccess?: (option: ProductOption) => void;
  onCancel: () => void;
  userId?: number;
}

export function ProductOptionForm({
  onSuccess,
  onCancel,
  userId,
}: ProductOptionFormProps) {
  const queryClient = useQueryClient();
  const [optionValues, setOptionValues] = useState<OptionValue[]>([
    { id: "1", name: "" },
  ]);

  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm<ProductOptionFormData>({
    defaultValues: {
      optionName: "",
      optionType: 1, // Default to dropdown type
    },
  });

  const createOptionMutation = useMutation({
    mutationFn: (data: CreateOptionRequest) => createProductOption(data),
    onSuccess: async (option) => {
      // Create all option values
      const valuePromises = optionValues
        .filter((v) => v.name.trim() !== "")
        .map((value) =>
          createOptionValue({
            optionId: option.id,
            name: value.name,
            colorCode: value.colorCode,
          })
        );

      await Promise.all(valuePromises);

      // Invalidate and refetch options
      await queryClient.invalidateQueries({ queryKey: ["productOptions"] });

      if (onSuccess) {
        onSuccess(option);
      }
    },
  });

  const handleAddValue = () => {
    const newId = Date.now().toString();
    setOptionValues([...optionValues, { id: newId, name: "" }]);
  };

  const handleRemoveValue = (id: string) => {
    if (optionValues.length > 1) {
      setOptionValues(optionValues.filter((v) => v.id !== id));
    }
  };

  const handleValueChange = (id: string, field: "name" | "colorCode", value: string) => {
    setOptionValues(
      optionValues.map((v) => (v.id === id ? { ...v, [field]: value } : v))
    );
  };

  const onSubmit = async (data: ProductOptionFormData) => {
    // Validate that at least one option value has a name
    const validValues = optionValues.filter((v) => v.name.trim() !== "");
    if (validValues.length === 0) {
      alert("Please add at least one option value");
      return;
    }

    try {
      await createOptionMutation.mutateAsync({
        name: data.optionName,
        type: data.optionType,
      });
    } catch (error) {
      console.error("Failed to create option:", error);
      alert("Failed to create product option. Please try again.");
    }
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
      {/* Option Name */}
      <div>
        <label className="block text-sm font-medium text-gray-700 mb-2">
          Option Name <span className="text-red-500">*</span>
        </label>
        <input
          type="text"
          {...register("optionName", {
            required: "Option name is required",
            minLength: {
              value: 1,
              message: "Option name cannot be empty",
            },
          })}
          placeholder="e.g., Size, Color, Material"
          className={cn(
            "w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500",
            errors.optionName && "border-red-500"
          )}
        />
        {errors.optionName && (
          <p className="mt-1 text-sm text-red-500">
            {errors.optionName.message}
          </p>
        )}
      </div>

      {/* Option Type */}
      <div>
        <label className="block text-sm font-medium text-gray-700 mb-2">
          Option Type <span className="text-red-500">*</span>
        </label>
        <select
          {...register("optionType", { required: true })}
          className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
        >
          <option value={1}>Dropdown</option>
          <option value={2}>Radio Buttons</option>
          <option value={3}>Checkboxes</option>
        </select>
      </div>

      {/* Option Values */}
      <div>
        <div className="flex items-center justify-between mb-3">
          <label className="block text-sm font-medium text-gray-700">
            Option Values <span className="text-red-500">*</span>
          </label>
          <button
            type="button"
            onClick={handleAddValue}
            className="text-sm text-blue-600 hover:text-blue-800 font-medium"
          >
            + Add Value
          </button>
        </div>

        <div className="space-y-3">
          {optionValues.map((value, index) => (
            <div
              key={value.id}
              className="flex items-start gap-3 p-3 border border-gray-200 rounded-md"
            >
              <div className="flex-1 space-y-2">
                <input
                  type="text"
                  value={value.name}
                  onChange={(e) =>
                    handleValueChange(value.id, "name", e.target.value)
                  }
                  placeholder={`Value ${index + 1}`}
                  className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
                <input
                  type="text"
                  value={value.colorCode || ""}
                  onChange={(e) =>
                    handleValueChange(value.id, "colorCode", e.target.value)
                  }
                  placeholder="Color code (optional, e.g., #FF0000)"
                  className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm"
                />
              </div>
              {optionValues.length > 1 && (
                <button
                  type="button"
                  onClick={() => handleRemoveValue(value.id)}
                  className="mt-2 text-red-600 hover:text-red-800"
                  title="Remove value"
                >
                  <svg
                    className="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"
                    />
                  </svg>
                </button>
              )}
            </div>
          ))}
        </div>
        <p className="mt-2 text-xs text-gray-500">
          Add at least one value for this option
        </p>
      </div>

      {/* Actions */}
      <div className="flex justify-end space-x-3 pt-4 border-t border-gray-200">
        <button
          type="button"
          onClick={onCancel}
          className="px-4 py-2 border border-gray-300 rounded-md text-gray-700 hover:bg-gray-50"
        >
          Cancel
        </button>
        <button
          type="submit"
          disabled={isSubmitting || createOptionMutation.isPending}
          className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {isSubmitting || createOptionMutation.isPending
            ? "Creating..."
            : "Create Option"}
        </button>
      </div>
    </form>
  );
}

