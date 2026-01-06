"use client";

/**
 * Add Product Page
 * Comprehensive form to create a new product with all required fields
 */

import React, { useState, useEffect } from "react";
import { useForm, Controller } from "react-hook-form";
import { useQuery, useMutation, QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { useRouter } from "next/navigation";
import { ImageCropper } from "../../shop/components/ImageCropper";
import {
  getProductOptions,
  getTaxStructures,
  getShippingProfiles,
  getTags,
  createTag,
  createProduct,
  CreateProductRequest,
} from "../api/productApi";
import { cn } from "@/lib/utils";

const queryClient = new QueryClient();

// Occasion options
const OCCASION_OPTIONS = [
  "Birthday",
  "Anniversary",
  "Wedding",
  "Graduation",
  "Valentine's Day",
  "Mother's Day",
  "Father's Day",
  "Christmas",
  "New Year",
  "Other",
];

// Weight units
const WEIGHT_UNITS = [
  { value: 1, label: "kg" },
  { value: 2, label: "g" },
  { value: 3, label: "lb" },
  { value: 4, label: "oz" },
];

interface ProductOptionSelection {
  optionId: number;
  optionValueIds: number[];
}

interface TagInput {
  id: string;
  value: string;
}

function AddProductPageContent() {
  const router = useRouter();
  const [imageFile, setImageFile] = useState<string | null>(null);
  const [showImageCropper, setShowImageCropper] = useState(false);
  const [tags, setTags] = useState<TagInput[]>([]);
  const [tagInput, setTagInput] = useState("");
  const [selectedOptions, setSelectedOptions] = useState<ProductOptionSelection[]>([]);

  const {
    register,
    handleSubmit,
    control,
    watch,
    setValue,
    formState: { errors },
  } = useForm<CreateProductRequest & { productName: string; description: string }>({
    defaultValues: {
      featured: false,
      canBeCustom: false,
      weightUnit: 1,
    },
  });

  const canBeCustom = watch("canBeCustom");

  // Fetch data
  const { data: productOptions = [] } = useQuery({
    queryKey: ["productOptions"],
    queryFn: getProductOptions,
  });

  const { data: taxStructures = [] } = useQuery({
    queryKey: ["taxStructures"],
    queryFn: getTaxStructures,
  });

  const { data: shippingProfiles = [] } = useQuery({
    queryKey: ["shippingProfiles"],
    queryFn: getShippingProfiles,
  });

  const { data: existingTags = [] } = useQuery({
    queryKey: ["tags"],
    queryFn: getTags,
  });

  // Find default shipping profile
  const defaultShippingProfile = shippingProfiles.find((p) => p.isDefault);

  useEffect(() => {
    if (defaultShippingProfile) {
      setValue("shippingProfileId", defaultShippingProfile.id);
    }
  }, [defaultShippingProfile, setValue]);

  const handleImageFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setImageFile(reader.result as string);
        setShowImageCropper(true);
      };
      reader.readAsDataURL(file);
    }
  };

  const handleImageCropComplete = (croppedImage: string) => {
    setValue("image", croppedImage);
    setShowImageCropper(false);
    setImageFile(null);
  };

  const handleAddTag = () => {
    if (tagInput.trim()) {
      const newTag: TagInput = {
        id: Date.now().toString(),
        value: tagInput.trim(),
      };
      setTags([...tags, newTag]);
      setTagInput("");
    }
  };

  const handleRemoveTag = (id: string) => {
    setTags(tags.filter((tag) => tag.id !== id));
  };

  const handleAddProductOption = () => {
    setSelectedOptions([
      ...selectedOptions,
      {
        optionId: 0,
        optionValueIds: [],
      },
    ]);
  };

  const handleUpdateProductOption = (index: number, optionId: number) => {
    const updated = [...selectedOptions];
    updated[index] = {
      optionId,
      optionValueIds: [],
    };
    setSelectedOptions(updated);
  };

  const handleUpdateOptionValues = (index: number, optionValueIds: number[]) => {
    const updated = [...selectedOptions];
    updated[index].optionValueIds = optionValueIds;
    setSelectedOptions(updated);
  };

  const handleRemoveProductOption = (index: number) => {
    setSelectedOptions(selectedOptions.filter((_, i) => i !== index));
  };

  const createProductMutation = useMutation({
    mutationFn: createProduct,
    onSuccess: (data) => {
      // Store product options in localStorage for inventory page (even if empty)
      const optionsToStore = selectedOptions
        .filter((so) => so.optionId > 0 && so.optionValueIds.length > 0)
        .map((so) => ({
          optionId: so.optionId,
          optionValueIds: so.optionValueIds,
        }));
      
      // Always store options (empty array if no options selected)
      localStorage.setItem(`product_options_${data.id}`, JSON.stringify(optionsToStore));
      
      // Navigate to inventory page with product ID
      router.push(`/dashboard/products/new/inventory?productId=${data.id}`);
    },
    onError: (error: Error) => {
      alert(`Failed to create product: ${error.message}`);
    },
  });

  const onSubmit = async (data: CreateProductRequest & { productName: string; description: string }) => {
    // Create tags if needed
    const tagNames = tags.map((t) => t.value);
    const tagIds: string[] = [];

    for (const tagName of tagNames) {
      const existingTag = existingTags.find((t) => t.name.toLowerCase() === tagName.toLowerCase());
      if (existingTag) {
        tagIds.push(existingTag.id.toString());
      } else {
        try {
          const newTag = await createTag(tagName);
          tagIds.push(newTag.id.toString());
        } catch (error) {
          console.error("Failed to create tag:", error);
        }
      }
    }

    const productData: CreateProductRequest = {
      name: data.productName,
      description: data.description,
      occasion: data.occasion,
      image: data.image,
      taxStructureId: data.taxStructureId,
      weight: data.weight ? parseFloat(data.weight.toString()) : undefined,
      weightUnit: data.weightUnit,
      shippingProfileId: data.shippingProfileId || defaultShippingProfile?.id,
      featured: data.featured || false,
      canBeCustom: data.canBeCustom || false,
      customPrompt: data.canBeCustom ? data.customPrompt : undefined,
      tags: tagIds,
      productOptions: selectedOptions
        .filter((so) => so.optionId > 0 && so.optionValueIds.length > 0)
        .map((so) => ({
          optionId: so.optionId,
          optionValueIds: so.optionValueIds,
        })),
    };

    createProductMutation.mutate(productData);
  };

  return (
    <div className="max-w-4xl mx-auto">
      <h1 className="text-3xl font-bold mb-6">Add Product</h1>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        {/* Basic Information */}
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
          <h2 className="text-xl font-semibold mb-4">Basic Information</h2>
          
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Product Name *
            </label>
            <input
              type="text"
              {...register("productName", { required: "Product name is required" })}
              className={cn(
                "w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500",
                errors.productName && "border-red-500"
              )}
            />
            {errors.productName && (
              <p className="mt-1 text-sm text-red-500">{errors.productName.message}</p>
            )}
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Description
            </label>
            <textarea
              {...register("description")}
              rows={4}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
          </div>
        </div>

        {/* Occasion */}
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
          <h2 className="text-xl font-semibold mb-4">Occasion</h2>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Occasion
            </label>
            <select
              {...register("occasion")}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              <option value="">Select occasion</option>
              {OCCASION_OPTIONS.map((occasion) => (
                <option key={occasion} value={occasion}>
                  {occasion}
                </option>
              ))}
            </select>
          </div>
        </div>

        {/* Image Upload */}
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
          <h2 className="text-xl font-semibold mb-4">Product Image</h2>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Upload Image (1:1)
            </label>
            <input
              type="file"
              accept="image/*"
              onChange={handleImageFileChange}
              className="w-full px-3 py-2 border border-gray-300 rounded-md"
            />
            {watch("image") && (
              <div className="mt-4">
                <img
                  src={watch("image")}
                  alt="Product preview"
                  className="w-32 h-32 object-cover rounded-md"
                />
              </div>
            )}
          </div>
        </div>

        {/* Tax Structure */}
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
          <h2 className="text-xl font-semibold mb-4">Tax & Shipping</h2>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Tax Structure
            </label>
            <select
              {...register("taxStructureId", { valueAsNumber: true })}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              <option value="">Select tax structure</option>
              {taxStructures.map((tax) => (
                <option key={tax.id} value={tax.id}>
                  {tax.name}
                </option>
              ))}
            </select>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Weight
              </label>
              <input
                type="number"
                step="0.01"
                {...register("weight", { valueAsNumber: true })}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                placeholder="0.00"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Weight Unit
              </label>
              <select
                {...register("weightUnit", { valueAsNumber: true })}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              >
                {WEIGHT_UNITS.map((unit) => (
                  <option key={unit.value} value={unit.value}>
                    {unit.label}
                  </option>
                ))}
              </select>
            </div>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Shipping Profile
            </label>
            <select
              {...register("shippingProfileId", { valueAsNumber: true })}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              {shippingProfiles.map((profile) => (
                <option key={profile.id} value={profile.id}>
                  {profile.name} {profile.isDefault ? "(Default)" : ""}
                </option>
              ))}
            </select>
          </div>
        </div>

        {/* Featured & Custom */}
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
          <h2 className="text-xl font-semibold mb-4">Product Settings</h2>
          
          <div className="flex items-center">
            <Controller
              name="featured"
              control={control}
              render={({ field: { value, onChange } }) => (
                <label className="flex items-center cursor-pointer">
                  <input
                    type="checkbox"
                    checked={value || false}
                    onChange={(e) => onChange(e.target.checked)}
                    className="mr-2 h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
                  />
                  <span className="text-sm font-medium text-gray-700">Mark Item as Featured</span>
            </label>
              )}
            />
          </div>

          <div className="flex items-center">
            <Controller
              name="canBeCustom"
              control={control}
              render={({ field: { value, onChange } }) => (
                <label className="flex items-center cursor-pointer">
            <input
                    type="checkbox"
                    checked={value || false}
                    onChange={(e) => onChange(e.target.checked)}
                    className="mr-2 h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
                  />
                  <span className="text-sm font-medium text-gray-700">Mark Item as Can Be Custom</span>
                </label>
              )}
            />
          </div>

          {canBeCustom && (
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Custom Prompt *
              </label>
              <textarea
                {...register("customPrompt", {
                  required: canBeCustom ? "Custom prompt is required when item can be custom" : false,
                })}
                rows={3}
                className={cn(
                  "w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500",
                  errors.customPrompt && "border-red-500"
                )}
                placeholder="Enter the prompt for custom products..."
              />
              {errors.customPrompt && (
                <p className="mt-1 text-sm text-red-500">{errors.customPrompt.message}</p>
              )}
            </div>
          )}
        </div>

        {/* Tags */}
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
          <h2 className="text-xl font-semibold mb-4">Tags</h2>
          <div>
            <div className="flex gap-2 mb-2">
              <input
                type="text"
                value={tagInput}
                onChange={(e) => setTagInput(e.target.value)}
                onKeyPress={(e) => {
                  if (e.key === "Enter") {
                    e.preventDefault();
                    handleAddTag();
                  }
                }}
                placeholder="Enter tag and press Enter"
                className="flex-1 px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
              <button
                type="button"
                onClick={handleAddTag}
                className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700"
              >
                Add
              </button>
            </div>
            <div className="flex flex-wrap gap-2">
              {tags.map((tag) => (
                <span
                  key={tag.id}
                  className="inline-flex items-center px-3 py-1 bg-blue-100 text-blue-800 rounded-full text-sm"
                >
                  {tag.value}
            <button
                    type="button"
                    onClick={() => handleRemoveTag(tag.id)}
                    className="ml-2 text-blue-600 hover:text-blue-800"
            >
                    ×
            </button>
                </span>
              ))}
            </div>
          </div>
        </div>

        {/* Product Options */}
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
          <div className="flex justify-between items-center mb-4">
            <h2 className="text-xl font-semibold">Product Options</h2>
            <button
              type="button"
              onClick={handleAddProductOption}
              className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700"
            >
              Add Option
            </button>
          </div>

          {selectedOptions.map((option, index) => {
            const selectedOption = productOptions.find((o) => o.id === option.optionId);
            return (
              <div key={index} className="p-4 border border-gray-200 rounded-md space-y-3">
                <div className="flex justify-between items-center">
                  <h3 className="font-medium">Option {index + 1}</h3>
                  <button
                    type="button"
                    onClick={() => handleRemoveProductOption(index)}
                    className="text-red-600 hover:text-red-800 text-sm"
                  >
                    Remove
                  </button>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Select Option
                  </label>
                  <select
                    value={option.optionId || ""}
                    onChange={(e) => handleUpdateProductOption(index, parseInt(e.target.value))}
                    className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                  >
                    <option value="">Select an option</option>
                    {productOptions.map((opt) => (
                      <option key={opt.id} value={opt.id}>
                        {opt.name}
                      </option>
                    ))}
                  </select>
                </div>
                {selectedOption && (
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Select Option Values
                    </label>
                    <div className="space-y-2">
                      {selectedOption.values.map((value) => (
                        <label key={value.id} className="flex items-center">
                          <input
                            type="checkbox"
                            checked={option.optionValueIds.includes(value.id)}
                            onChange={(e) => {
                              const currentIds = option.optionValueIds;
                              if (e.target.checked) {
                                handleUpdateOptionValues(index, [...currentIds, value.id]);
                              } else {
                                handleUpdateOptionValues(
                                  index,
                                  currentIds.filter((id) => id !== value.id)
                                );
                              }
                            }}
                            className="mr-2 h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
                          />
                          <span className="text-sm text-gray-700">{value.name}</span>
                        </label>
                      ))}
                    </div>
                  </div>
                )}
              </div>
            );
          })}
        </div>

        {/* Submit Button */}
        <div className="flex justify-end space-x-4 pt-4">
          <button
            type="button"
            onClick={() => router.back()}
            className="px-6 py-2 border border-gray-300 rounded-md text-gray-700 hover:bg-gray-50"
            >
              Cancel
          </button>
          <button
            type="submit"
            disabled={createProductMutation.isPending}
            className="px-6 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {createProductMutation.isPending ? "Creating..." : "Continue to Inventory"}
            </button>
          </div>
        </form>

      {showImageCropper && imageFile && (
        <ImageCropper
          image={imageFile}
          onCropComplete={handleImageCropComplete}
          onCancel={() => {
            setShowImageCropper(false);
            setImageFile(null);
          }}
        />
      )}
    </div>
  );
}

export default function AddProductPage() {
  return (
    <QueryClientProvider client={queryClient}>
      <AddProductPageContent />
    </QueryClientProvider>
  );
}
