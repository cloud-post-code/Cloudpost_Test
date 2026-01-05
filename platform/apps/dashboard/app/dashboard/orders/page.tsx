/**
 * Orders Management Page
 * View and manage orders
 */

export default function OrdersPage() {
  return (
    <div>
      <h1 className="text-3xl font-bold mb-6">Orders</h1>
      <div className="bg-white rounded-lg shadow">
        <div className="p-4 border-b border-gray-200">
          <div className="flex space-x-4">
            <input
              type="text"
              placeholder="Search orders..."
              className="flex-1 px-4 py-2 border border-gray-300 rounded-md"
            />
            <select className="px-4 py-2 border border-gray-300 rounded-md">
              <option>All Status</option>
            </select>
          </div>
        </div>
        <div className="p-4">
          <table className="w-full">
            <thead>
              <tr className="border-b border-gray-200">
                <th className="text-left py-3 px-4 font-medium">Order #</th>
                <th className="text-left py-3 px-4 font-medium">Customer</th>
                <th className="text-left py-3 px-4 font-medium">Date</th>
                <th className="text-left py-3 px-4 font-medium">Total</th>
                <th className="text-left py-3 px-4 font-medium">Status</th>
                <th className="text-left py-3 px-4 font-medium">Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr className="border-b border-gray-100">
                <td className="py-3 px-4">ORD-001</td>
                <td className="py-3 px-4">John Doe</td>
                <td className="py-3 px-4">2024-01-15</td>
                <td className="py-3 px-4">$199.99</td>
                <td className="py-3 px-4">
                  <span className="px-2 py-1 bg-yellow-100 text-yellow-800 rounded text-sm">
                    Pending
                  </span>
                </td>
                <td className="py-3 px-4">
                  <a href="/dashboard/orders/1" className="text-blue-600 hover:text-blue-800">
                    View
                  </a>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

