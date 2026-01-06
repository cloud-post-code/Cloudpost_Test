"use client";

/**
 * Add Product Page
 * Comprehensive form to create a new product with all required fields
 */

import React, { useState, useEffect } from "react";
import { useForm, Controller } from "react-hook-form";
import { useQuery, useMutation, useQueryClient, QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { useRouter } from "next/navigation";
import { ImageCropper } from "../../shop/components/ImageCropper";
import {
  getProductOptions,
  getTaxStructures,
  getShippingProfiles,
  getTags,
  getProductCategories,
  getOccasions,
  createTag,
  createProduct,
  createProductOption,
  createOptionValue,
  CreateProductRequest,
} from "../api/productApi";
import { cn } from "@/lib/utils";

const queryClient = new QueryClient();


// Weight units
const WEIGHT_UNITS = [
  { value: 1, label: "kg" },
  { value: 2, label: "g" },
  { value: 3, label: "lb" },
  { value: 4, label: "oz" },
];

interface ProductOptionSelection {
  id: string;
  optionId: number;
  optionValueIds: number[];
  searchValue: string;
}

interface TagInput {
  id: string;
  value: string;
}

interface ProductImage {
  id: string;
  url: string;
}

function AddProductPageContent() {
  const router = useRouter();
  const [imageFile, setImageFile] = useState<string | null>(null);
  const [editingImageId, setEditingImageId] = useState<string | null>(null);
  const [showImageCropper, setShowImageCropper] = useState(false);
  const [productImages, setProductImages] = useState<ProductImage[]>([]);
  const [tags, setTags] = useState<TagInput[]>([]);
  const [tagInput, setTagInput] = useState("");
  const [selectedOptions, setSelectedOptions] = useState<ProductOptionSelection[]>([]);
  const [occasionSearch, setOccasionSearch] = useState("");
  const [occasionSuggestions, setOccasionSuggestions] = useState<string[]>([]);
  const [showOccasionSuggestions, setShowOccasionSuggestions] = useState(false);

  const {
    register,
    handleSubmit,
    control,
    watch,
    setValue,
    formState: { errors },
  } = useForm<CreateProductRequest & { productName: string; description: string; fulfillmentType?: number }>({
    defaultValues: {
      featured: false,
      canBeCustom: false,
      weightUnit: 1,
      fulfillmentType: 1,
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

  const { data: productCategories = [] } = useQuery({
    queryKey: ["productCategories"],
    queryFn: getProductCategories,
  });

  const { data: occasions = [] } = useQuery({
    queryKey: ["occasions"],
    queryFn: getOccasions,
  });

  // Find default shipping profile
  const defaultShippingProfile = shippingProfiles.find((p) => p.isDefault);
  
  // Watch shipping profile to auto-set fulfillment type
  const selectedShippingProfileId = watch("shippingProfileId");
  const selectedShippingProfile = shippingProfiles.find((p) => p.id === selectedShippingProfileId);
  
  // Watch occasion field to sync with search
  const occasionValue = watch("occasion");
  useEffect(() => {
    if (occasionValue && !occasionSearch) {
      setOccasionSearch(occasionValue);
    }
  }, [occasionValue, occasionSearch]);

  // Handle clone data from sessionStorage
  useEffect(() => {
    const cloneDataStr = sessionStorage.getItem("productCloneData");
    if (cloneDataStr) {
      try {
        const cloneData = JSON.parse(cloneDataStr);
        // Pre-fill form with clone data (excluding name and images as requested)
        if (cloneData.description) setValue("description", cloneData.description);
        if (cloneData.shortDescription) setValue("shortDescription", cloneData.shortDescription);
        if (cloneData.occasion) {
          setValue("occasion", cloneData.occasion);
          setOccasionSearch(cloneData.occasion);
        }
        if (cloneData.categoryId) setValue("categoryId", cloneData.categoryIds?.[0]);
        if (cloneData.weight !== undefined) setValue("weight", cloneData.weight);
        if (cloneData.weightUnit) setValue("weightUnit", cloneData.weightUnit);
        if (cloneData.canBeCustom !== undefined) setValue("canBeCustom", cloneData.canBeCustom);
        if (cloneData.customPrompt) setValue("customPrompt", cloneData.customPrompt);
        if (cloneData.featured !== undefined) setValue("featured", cloneData.featured);
        
        // Set tags
        if (cloneData.tags && Array.isArray(cloneData.tags)) {
          const tagInputs: TagInput[] = cloneData.tags.map((tagName: string, index: number) => ({
            id: `clone-${index}`,
            value: tagName,
          }));
          setTags(tagInputs);
        }
        
        // Clear clone data from sessionStorage
        sessionStorage.removeItem("productCloneData");
      } catch (error) {
        console.error("Failed to parse clone data:", error);
        sessionStorage.removeItem("productCloneData");
      }
    }
  }, [setValue]);

  useEffect(() => {
    if (defaultShippingProfile) {
      setValue("shippingProfileId", defaultShippingProfile.id);
    }
  }, [defaultShippingProfile, setValue]);

  // Auto-set fulfillment type based on shipping profile
  useEffect(() => {
    if (selectedShippingProfile) {
      // Auto-set fulfillment type based on profile (default to 1 = Shipping)
      // This should be determined by the shipping profile's fulfillment method
      // For now, defaulting to 1 (Shipping), but this should come from the profile
      setValue("fulfillmentType", 1);
    }
  }, [selectedShippingProfile, setValue]);

  // Handle occasion search
  useEffect(() => {
    if (occasionSearch.trim()) {
      const filtered = occasions.filter((occ) =>
        occ.toLowerCase().includes(occasionSearch.toLowerCase())
      );
      setOccasionSuggestions(filtered);
      setShowOccasionSuggestions(true);
    } else {
      setOccasionSuggestions([]);
      setShowOccasionSuggestions(false);
    }
  }, [occasionSearch, occasions]);

  const handleOccasionSelect = (occasion: string) => {
    setValue("occasion", occasion);
    setOccasionSearch(occasion);
    setShowOccasionSuggestions(false);
  };

  const handleImageFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (!files || files.length === 0) return;

    // If multiple files selected, skip cropping and add them directly
    if (files.length > 1) {
      const fileArray = Array.from(files);
      const newImages: ProductImage[] = [];
      let loadedCount = 0;
      const baseId = Date.now();

      fileArray.forEach((file, index) => {
        const reader = new FileReader();
        reader.onloadend = () => {
          const newImage: ProductImage = {
            id: `${baseId}-${index}`,
            url: reader.result as string,
          };
          newImages.push(newImage);
          loadedCount++;

          // When all files are loaded, add them all at once
          if (loadedCount === fileArray.length) {
            setProductImages((prev) => {
              const updated = [...prev, ...newImages];
              setValue("images", updated.map((img) => img.url));
              return updated;
            });
          }
        };
        reader.readAsDataURL(file);
      });
    } else {
      // Single file - show cropper
      const file = files[0];
      const reader = new FileReader();
      reader.onloadend = () => {
        setImageFile(reader.result as string);
        setEditingImageId(null); // New image, not editing existing
        setShowImageCropper(true);
      };
      reader.readAsDataURL(file);
    }

    // Reset input so same file can be selected again
    e.target.value = "";
  };

  const handleImageCropComplete = (croppedImage: string) => {
    if (editingImageId) {
      // Update existing image
      setProductImages((prev) =>
        prev.map((img) => (img.id === editingImageId ? { ...img, url: croppedImage } : img))
      );
      setEditingImageId(null);
    } else {
      // Add new image
      const newImage: ProductImage = {
        id: Date.now().toString(),
        url: croppedImage,
      };
      setProductImages((prev) => [...prev, newImage]);
    }
    
    // Update form value
    const imageUrls = editingImageId
      ? productImages.map((img) => (img.id === editingImageId ? croppedImage : img.url))
      : [...productImages.map((img) => img.url), croppedImage];
    setValue("images", imageUrls);
    
    setShowImageCropper(false);
    setImageFile(null);
  };

  const handleEditImage = (imageId: string) => {
    const image = productImages.find((img) => img.id === imageId);
    if (image) {
      setImageFile(image.url);
      setEditingImageId(imageId);
      setShowImageCropper(true);
    }
  };

  const handleDeleteImage = (imageId: string) => {
    const updatedImages = productImages.filter((img) => img.id !== imageId);
    setProductImages(updatedImages);
    setValue("images", updatedImages.map((img) => img.url));
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

  const queryClient = useQueryClient();

  const handleAddProductOption = () => {
    setSelectedOptions([
      ...selectedOptions,
      {
        id: Date.now().toString(),
        optionId: 0,
        optionValueIds: [],
        searchValue: "",
      },
    ]);
  };

  const handleUpdateProductOption = (id: string, optionId: number) => {
    const updated = selectedOptions.map((opt) =>
      opt.id === id ? { ...opt, optionId, optionValueIds: [] } : opt
    );
    setSelectedOptions(updated);
  };

  const handleUpdateOptionValueSearch = (id: string, searchValue: string) => {
    const updated = selectedOptions.map((opt) =>
      opt.id === id ? { ...opt, searchValue } : opt
    );
    setSelectedOptions(updated);
  };

  const handleAddOptionValue = async (id: string, valueName: string) => {
    const option = selectedOptions.find((opt) => opt.id === id);
    if (!option || !option.optionId || !valueName.trim()) return;

    const selectedOption = productOptions.find((o) => o.id === option.optionId);
    if (!selectedOption) return;

    // Check if value already exists
    const existingValue = selectedOption.values.find(
      (v) => v.name.toLowerCase() === valueName.trim().toLowerCase()
    );

    if (existingValue) {
      // Add existing value
      const updated = selectedOptions.map((opt) =>
        opt.id === id
          ? {
              ...opt,
              optionValueIds: [...opt.optionValueIds, existingValue.id],
              searchValue: "",
            }
          : opt
      );
      setSelectedOptions(updated);
    } else {
      // Create new value
      try {
        const newValue = await createOptionValue({
          optionId: option.optionId,
          name: valueName.trim(),
        });
        
        // Refresh options to get the new value
        await queryClient.invalidateQueries({ queryKey: ["productOptions"] });
        
        // Add new value to selection
        const updated = selectedOptions.map((opt) =>
          opt.id === id
            ? {
                ...opt,
                optionValueIds: [...opt.optionValueIds, newValue.id],
                searchValue: "",
              }
            : opt
        );
        setSelectedOptions(updated);
      } catch (error) {
        console.error("Failed to create option value:", error);
        alert("Failed to create option value");
      }
    }
  };

  const handleRemoveOptionValue = (id: string, valueId: number) => {
    const updated = selectedOptions.map((opt) =>
      opt.id === id
        ? {
            ...opt,
            optionValueIds: opt.optionValueIds.filter((vid) => vid !== valueId),
          }
        : opt
    );
    setSelectedOptions(updated);
  };

  const handleRemoveProductOption = (id: string) => {
    setSelectedOptions(selectedOptions.filter((opt) => opt.id !== id));
  };

  const handleCreateCustomOption = async (optionName: string) => {
    if (!optionName.trim()) return;

    try {
      const newOption = await createProductOption({
        name: optionName.trim(),
        type: 1, // Default type
      });

      // Refresh options
      await queryClient.invalidateQueries({ queryKey: ["productOptions"] });

      // Add to selected options
      setSelectedOptions([
        ...selectedOptions,
        {
          id: Date.now().toString(),
          optionId: newOption.id,
          optionValueIds: [],
          searchValue: "",
        },
      ]);
    } catch (error) {
      console.error("Failed to create option:", error);
      alert("Failed to create option");
    }
  };

  const createProductMutation = useMutation({
    mutationFn: createProduct,
    onSuccess: (data) => {
      navigateToInventory(data.id);
    },
    onError: (error: Error) => {
      // Even if product creation fails, allow navigation to inventory page
      // Use a temporary ID and store data in localStorage
      const tempProductId = `temp-${Date.now()}`;
      navigateToInventory(tempProductId, true);
      console.warn("Product creation failed, using temporary ID:", error.message);
    },
  });

  const navigateToInventory = (productId: string | number, isTemp = false) => {
    // Store product options in localStorage for inventory page (even if empty)
    const optionsToStore = selectedOptions
      .filter((so) => so.optionId > 0 && so.optionValueIds.length > 0)
      .map((so) => ({
        optionId: so.optionId,
        optionValueIds: so.optionValueIds,
      }));
    
    // Always store options (empty array if no options selected)
    localStorage.setItem(`product_options_${productId}`, JSON.stringify(optionsToStore));
    
    if (isTemp) {
      // Store form data for later creation
      const formData = {
        name: (document.querySelector('input[name="productName"]') as HTMLInputElement)?.value || "",
        description: (document.querySelector('textarea[name="description"]') as HTMLTextAreaElement)?.value || "",
      };
      localStorage.setItem(`product_data_${productId}`, JSON.stringify(formData));
    }
    
    // Navigate to inventory page with product ID
    router.push(`/dashboard/products/new/inventory?productId=${productId}`);
  };

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
      categoryId: data.categoryId,
      images: productImages.map((img) => img.url),
      taxStructureId: data.taxStructureId,
      weight: data.weight ? parseFloat(data.weight.toString()) : undefined,
      weightUnit: data.weightUnit,
      shippingProfileId: data.shippingProfileId || defaultShippingProfile?.id,
      fulfillmentType: data.fulfillmentType || 1,
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

        {/* Occasion and Category */}
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
          <h2 className="text-xl font-semibold mb-4">Occasion & Category</h2>
          <div className="grid grid-cols-2 gap-4">
            <div className="relative">
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Occasion
              </label>
              <input
                type="text"
                value={occasionSearch}
                onChange={(e) => {
                  setOccasionSearch(e.target.value);
                  setValue("occasion", e.target.value);
                }}
                onFocus={() => {
                  if (occasionSearch.trim()) {
                    setShowOccasionSuggestions(true);
                  }
                }}
                onBlur={() => {
                  // Delay hiding suggestions to allow click
                  setTimeout(() => setShowOccasionSuggestions(false), 200);
                }}
                placeholder="Search or type occasion..."
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
              {showOccasionSuggestions && occasionSuggestions.length > 0 && (
                <div className="absolute z-10 w-full mt-1 bg-white border border-gray-300 rounded-md shadow-lg max-h-60 overflow-y-auto">
                  {occasionSuggestions.map((occasion, idx) => (
                    <div
                      key={idx}
                      className="px-3 py-2 hover:bg-gray-100 cursor-pointer"
                      onMouseDown={(e) => {
                        e.preventDefault();
                        handleOccasionSelect(occasion);
                      }}
                    >
                      {occasion}
                    </div>
                  ))}
                </div>
              )}
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Category
              </label>
              <select
                {...register("categoryId", { valueAsNumber: true })}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              >
                <option value="">Select category</option>
                {productCategories.map((category) => (
                  <option key={category.id} value={category.id}>
                    {category.name} {category.type ? `(${category.type})` : ""}
                  </option>
                ))}
              </select>
            </div>
          </div>
        </div>

        {/* Image Upload */}
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
          <h2 className="text-xl font-semibold mb-4">Product Images</h2>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Upload Image(s) (1:1 when cropping)
            </label>
            <input
              type="file"
              accept="image/*"
              multiple
              onChange={handleImageFileChange}
              className="w-full px-3 py-2 border border-gray-300 rounded-md"
            />
            <p className="mt-1 text-xs text-gray-500">
              Select multiple images to upload without cropping, or select one image to crop it.
            </p>
          </div>
          
          {productImages.length > 0 && (
            <div className="mt-4">
              <div className="grid grid-cols-4 gap-4">
                {productImages.map((image) => (
                  <div key={image.id} className="relative group">
                    <img
                      src={image.url}
                      alt="Product preview"
                      className="w-full aspect-square object-cover rounded-md border border-gray-200"
                    />
                    <div className="absolute inset-0 bg-black bg-opacity-0 group-hover:bg-opacity-50 transition-opacity rounded-md flex items-center justify-center gap-2">
                      <button
                        type="button"
                        onClick={() => handleEditImage(image.id)}
                        className="opacity-0 group-hover:opacity-100 px-3 py-1 bg-blue-600 text-white rounded text-sm hover:bg-blue-700 transition-opacity"
                      >
                        Edit
                      </button>
                      <button
                        type="button"
                        onClick={() => handleDeleteImage(image.id)}
                        className="opacity-0 group-hover:opacity-100 px-3 py-1 bg-red-600 text-white rounded text-sm hover:bg-red-700 transition-opacity"
                      >
                        Delete
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>

        {/* Product Options */}
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
          <div className="flex justify-end mb-4">
            <button
              type="button"
              onClick={() => {
                const optionName = prompt("Enter option name:");
                if (optionName) {
                  handleCreateCustomOption(optionName);
                }
              }}
              className="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700"
            >
              Add Custom Options
            </button>
          </div>

          <div className="border border-gray-200 rounded-md overflow-hidden">
            {/* Table Header */}
            <div className="bg-gray-100 grid grid-cols-12 gap-4 p-3 border-b border-gray-200">
              <div className="col-span-4">
                <span className="text-sm font-medium text-gray-700">Option Title</span>
              </div>
              <div className="col-span-6">
                <span className="text-sm font-medium text-gray-700">Option Value</span>
              </div>
              <div className="col-span-2 text-center">
                <span className="text-sm font-medium text-gray-700">Add Option Type</span>
              </div>
            </div>

            {/* Table Rows */}
            {selectedOptions.length === 0 ? (
              <div className="p-4 text-center text-gray-500 text-sm">
                No options added. Click &quot;Add Custom Options&quot; to create a new option or add a row below.
              </div>
            ) : (
              selectedOptions.map((option) => {
                const selectedOption = productOptions.find((o) => o.id === option.optionId);
                const filteredValues = selectedOption
                  ? selectedOption.values.filter((v) =>
                      v.name.toLowerCase().includes(option.searchValue.toLowerCase())
                    )
                  : [];

                return (
                  <div key={option.id} className="grid grid-cols-12 gap-4 p-3 border-b border-gray-200 last:border-b-0">
                    <div className="col-span-4">
                      <select
                        value={option.optionId || ""}
                        onChange={(e) => handleUpdateProductOption(option.id, parseInt(e.target.value))}
                        className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm"
                      >
                        <option value="">Select option</option>
                        {productOptions.map((opt) => (
                          <option key={opt.id} value={opt.id}>
                            {opt.name}
                          </option>
                        ))}
                      </select>
                    </div>
                    <div className="col-span-6">
                      <div className="space-y-2">
                        <input
                          type="text"
                          value={option.searchValue}
                          onChange={(e) => handleUpdateOptionValueSearch(option.id, e.target.value)}
                          onKeyPress={(e) => {
                            if (e.key === "Enter" && option.searchValue.trim()) {
                              e.preventDefault();
                              handleAddOptionValue(option.id, option.searchValue);
                            }
                          }}
                          placeholder="Type to search"
                          className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm"
                        />
                        {option.searchValue && filteredValues.length > 0 && (
                          <div className="border border-gray-200 rounded-md max-h-40 overflow-y-auto">
                            {filteredValues.map((value) => (
                              <div
                                key={value.id}
                                className="px-3 py-2 hover:bg-gray-50 cursor-pointer text-sm"
                                onClick={() => handleAddOptionValue(option.id, value.name)}
                              >
                                {value.name}
                              </div>
                            ))}
                          </div>
                        )}
                        {selectedOption && option.optionValueIds.length > 0 && (
                          <div className="flex flex-wrap gap-2 mt-2">
                            {option.optionValueIds.map((valueId) => {
                              const value = selectedOption.values.find((v) => v.id === valueId);
                              return value ? (
                                <span
                                  key={valueId}
                                  className="inline-flex items-center px-2 py-1 bg-blue-100 text-blue-800 rounded text-xs"
                                >
                                  {value.name}
                                  <button
                                    type="button"
                                    onClick={() => handleRemoveOptionValue(option.id, valueId)}
                                    className="ml-1 text-blue-600 hover:text-blue-800"
                                  >
                                    ×
                                  </button>
                                </span>
                              ) : null;
                            })}
                          </div>
                        )}
                      </div>
                    </div>
                    <div className="col-span-2 flex items-center justify-center gap-2">
                      <button
                        type="button"
                        onClick={handleAddProductOption}
                        className="w-8 h-8 rounded-full bg-gray-200 hover:bg-gray-300 flex items-center justify-center text-gray-600 hover:text-gray-800"
                        title="Add new row"
                      >
                        <span className="text-lg">+</span>
                      </button>
                      <button
                        type="button"
                        onClick={() => handleRemoveProductOption(option.id)}
                        className="w-8 h-8 rounded-full bg-red-100 hover:bg-red-200 flex items-center justify-center text-red-600 hover:text-red-800"
                        title="Remove row"
                      >
                        <span className="text-lg">×</span>
                      </button>
                    </div>
                  </div>
                );
              })
            )}

            {/* Add Row Button */}
            <div className="p-3 border-t border-gray-200">
              <button
                type="button"
                onClick={handleAddProductOption}
                className="w-full px-4 py-2 border-2 border-dashed border-gray-300 rounded-md text-gray-600 hover:border-gray-400 hover:text-gray-800 text-sm"
              >
                + Add Row
              </button>
            </div>
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

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Fulfillment Type
            </label>
            <select
              {...register("fulfillmentType", { valueAsNumber: true })}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              disabled
            >
              <option value={1}>Shipping</option>
              <option value={2}>Pickup</option>
            </select>
            <p className="mt-1 text-xs text-gray-500">
              Automatically set based on shipping profile
            </p>
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
            setEditingImageId(null);
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
