/**
 * Inventory Management Page
 * Manage product inventory
 */

export default function InventoryPage() {
  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-3xl font-bold">Inventory</h1>
        <button className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700">
          Bulk Update
        </button>
      </div>
      <div className="bg-white rounded-lg shadow">
        <div className="p-4">
          <p className="text-gray-500">Inventory management coming soon...</p>
        </div>
      </div>
    </div>
  );
}

