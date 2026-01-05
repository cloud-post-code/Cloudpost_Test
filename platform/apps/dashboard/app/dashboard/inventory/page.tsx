/**
 * Inventory Management Page
 * Manage product inventory, stock levels, and variants
 */

export default function InventoryPage() {
  return (
    <div>
      <h1 className="text-3xl font-bold mb-6">Inventory Management</h1>
      <div className="bg-white rounded-lg shadow">
        <div className="p-4 border-b border-gray-200">
          <input
            type="text"
            placeholder="Search inventory..."
            className="w-full px-4 py-2 border border-gray-300 rounded-md"
          />
        </div>
        <div className="p-4">
          <table className="w-full">
            <thead>
              <tr className="border-b border-gray-200">
                <th className="text-left py-3 px-4 font-medium">Product</th>
                <th className="text-left py-3 px-4 font-medium">SKU</th>
                <th className="text-left py-3 px-4 font-medium">Current Stock</th>
                <th className="text-left py-3 px-4 font-medium">Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr className="border-b border-gray-100">
                <td className="py-3 px-4">Sample Product</td>
                <td className="py-3 px-4">SKU-001</td>
                <td className="py-3 px-4">50</td>
                <td className="py-3 px-4">
                  <button className="text-blue-600 hover:text-blue-800">Update</button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

