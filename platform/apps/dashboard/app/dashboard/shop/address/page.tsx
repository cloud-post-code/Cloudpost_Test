"use client";

import { useEffect } from "react";
import { useRouter } from "next/navigation";

export default function ShopAddressRedirect() {
  const router = useRouter();
  
  useEffect(() => {
    router.replace("/dashboard/shop/info");
  }, [router]);

  return (
    <div className="flex items-center justify-center min-h-[400px]">
      <div className="text-gray-500">Redirecting...</div>
    </div>
  );
}
