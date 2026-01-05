/**
 * Wallet Page
 * View wallet balance, transactions, and withdrawal requests
 */

export default function WalletPage() {
  return (
    <div>
      <h1 className="text-3xl font-bold mb-6">Wallet</h1>
      <div className="grid grid-cols-3 gap-6 mb-6">
        <div className="bg-white rounded-lg shadow p-6">
          <h3 className="text-sm font-medium text-gray-500 mb-2">Available Balance</h3>
          <p className="text-3xl font-bold text-gray-900">$0.00</p>
        </div>
        <div className="bg-white rounded-lg shadow p-6">
          <h3 className="text-sm font-medium text-gray-500 mb-2">Pending</h3>
          <p className="text-3xl font-bold text-gray-900">$0.00</p>
        </div>
        <div className="bg-white rounded-lg shadow p-6">
          <h3 className="text-sm font-medium text-gray-500 mb-2">Total Earned</h3>
          <p className="text-3xl font-bold text-gray-900">$0.00</p>
        </div>
      </div>
      <div className="bg-white rounded-lg shadow">
        <div className="p-4 border-b border-gray-200">
          <h2 className="text-lg font-semibold">Transaction History</h2>
        </div>
        <div className="p-4">
          <p className="text-gray-500">No transactions yet</p>
        </div>
      </div>
    </div>
  );
}

