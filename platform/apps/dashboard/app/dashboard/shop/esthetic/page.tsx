"use client";

/**
 * Shop Esthetic Page
 */

import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { useShopForm } from "../hooks/useShopForm";
import { ImageCropper } from "../components/ImageCropper";
import { useState } from "react";

const queryClient = new QueryClient();

function ShopEstheticPageContent() {
  const { form, isLoading, onSubmit } = useShopForm();
  const { handleSubmit, watch, setValue } = form;
  const [logoImage, setLogoImage] = useState<string | null>(null);
  const [showLogoCropper, setShowLogoCropper] = useState(false);
  const [bannerImage, setBannerImage] = useState<string | null>(null);
  const [showBannerCropper, setShowBannerCropper] = useState(false);

  const handleLogoFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setLogoImage(reader.result as string);
        setShowLogoCropper(true);
      };
      reader.readAsDataURL(file);
    }
  };

  const handleBannerFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setBannerImage(reader.result as string);
        setShowBannerCropper(true);
      };
      reader.readAsDataURL(file);
    }
  };

  const handleBannerCropComplete = (croppedImage: string) => {
    setValue("banner", croppedImage);
    setShowBannerCropper(false);
    setBannerImage(null);
  };

  const handleLogoCropComplete = (croppedImage: string) => {
    setValue("logo", croppedImage);
    setShowLogoCropper(false);
    setLogoImage(null);
  };


  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="text-gray-500">Loading shop data...</div>
      </div>
    );
  }

  return (
    <div className="max-w-4xl mx-auto">
      <h1 className="text-3xl font-bold mb-6">Shop Esthetic</h1>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
        <div className="bg-white rounded-lg shadow p-6 space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">Logo (1:1)</label>
            <input
              type="file"
              accept="image/*"
              className="w-full px-3 py-2 border border-gray-300 rounded-md"
              onChange={handleLogoFileChange}
            />
            {watch("logo") && (
              <div className="mt-4">
                <img
                  src={watch("logo")}
                  alt="Logo preview"
                  className="w-32 h-32 object-cover rounded-md"
                />
              </div>
            )}
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">Banner</label>
            <input
              type="file"
              accept="image/*"
              className="w-full px-3 py-2 border border-gray-300 rounded-md"
              onChange={handleBannerFileChange}
            />
            {watch("banner") && (
              <div className="mt-4">
                <img
                  src={watch("banner")}
                  alt="Banner preview"
                  className="w-full h-48 object-cover rounded-md"
                />
              </div>
            )}
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

      {showLogoCropper && logoImage && (
        <ImageCropper
          image={logoImage}
          aspect={1}
          title="Crop Logo (1:1)"
          onCropComplete={handleLogoCropComplete}
          onCancel={() => {
            setShowLogoCropper(false);
            setLogoImage(null);
          }}
        />
      )}

      {showBannerCropper && bannerImage && (
        <ImageCropper
          image={bannerImage}
          aspect={3}
          title="Crop Banner (3:1)"
          onCropComplete={handleBannerCropComplete}
          onCancel={() => {
            setShowBannerCropper(false);
            setBannerImage(null);
          }}
        />
      )}

    </div>
  );
}

export default function ShopEstheticPage() {
  return (
    <QueryClientProvider client={queryClient}>
      <ShopEstheticPageContent />
    </QueryClientProvider>
  );
}

