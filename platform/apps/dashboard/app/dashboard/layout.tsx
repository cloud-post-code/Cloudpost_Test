/**
 * Dashboard layout
 * This will contain the sidebar, header, and main content area
 */

import { Sidebar } from "@/components/sidebar";
import { Header } from "@/components/header";
import { Breadcrumb } from "@/components/breadcrumb";

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="flex h-screen bg-gray-50">
      <Sidebar />
      <div className="flex-1 flex flex-col overflow-hidden">
        <Header />
        <div className="flex-1 overflow-y-auto p-6">
          <Breadcrumb />
          {children}
        </div>
      </div>
    </div>
  );
}

