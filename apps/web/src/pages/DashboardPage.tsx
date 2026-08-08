import React, { useEffect, useState } from 'react';
import { supabase } from '../lib/supabase';
import { Sidebar } from '../components/Sidebar';

export function DashboardPage() {
  const [stats, setStats] = useState({
    totalUsers: 0,
    totalProviders: 0,
    totalOrders: 0,
    revenue: 0,
  });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchStats = async () => {
      try {
        // Fetch data from Supabase
        const { data: users } = await supabase.from('users').select('id');
        const { data: providers } = await supabase.from('providers').select('id');
        const { data: orders } = await supabase.from('orders').select('total');

        setStats({
          totalUsers: users?.length || 0,
          totalProviders: providers?.length || 0,
          totalOrders: orders?.length || 0,
          revenue: orders?.reduce((sum, order) => sum + (order.total || 0), 0) || 0,
        });
      } catch (error) {
        console.error('Error fetching stats:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchStats();
  }, []);

  return (
    <div className="flex">
      <Sidebar />
      <main className="flex-1 bg-gray-50 p-8">
        <h1 className="text-3xl font-bold mb-8">Dashboard</h1>
        {loading ? (
          <div className="flex justify-center items-center h-64">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-indigo-600"></div>
          </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            <div className="bg-white p-6 rounded-lg shadow">
              <h3 className="text-gray-500 text-sm font-medium">Total Users</h3>
              <p className="text-3xl font-bold mt-2">{stats.totalUsers}</p>
            </div>
            <div className="bg-white p-6 rounded-lg shadow">
              <h3 className="text-gray-500 text-sm font-medium">Total Providers</h3>
              <p className="text-3xl font-bold mt-2">{stats.totalProviders}</p>
            </div>
            <div className="bg-white p-6 rounded-lg shadow">
              <h3 className="text-gray-500 text-sm font-medium">Total Orders</h3>
              <p className="text-3xl font-bold mt-2">{stats.totalOrders}</p>
            </div>
            <div className="bg-white p-6 rounded-lg shadow">
              <h3 className="text-gray-500 text-sm font-medium">Revenue</h3>
              <p className="text-3xl font-bold mt-2">${stats.revenue.toLocaleString()}</p>
            </div>
          </div>
        )}
      </main>
    </div>
  );
}
