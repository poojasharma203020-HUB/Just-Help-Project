import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { LogOut, Settings, Users, Package, ShoppingCart, BarChart3 } from 'lucide-react';

export function Sidebar() {
  const navigate = useNavigate();
  const { logout } = useAuth();

  const menuItems = [
    { label: 'Dashboard', icon: BarChart3, path: '/' },
    { label: 'Users', icon: Users, path: '/users' },
    { label: 'Providers', icon: Package, path: '/providers' },
    { label: 'Orders', icon: ShoppingCart, path: '/orders' },
    { label: 'Settings', icon: Settings, path: '/settings' },
  ];

  return (
    <aside className="w-64 bg-gray-900 text-white h-screen flex flex-col">
      <div className="p-6 border-b border-gray-700">
        <h1 className="text-2xl font-bold">JustHelp</h1>
      </div>
      <nav className="flex-1 p-4">
        {menuItems.map((item) => {
          const Icon = item.icon;
          return (
            <button
              key={item.path}
              onClick={() => navigate(item.path)}
              className="w-full flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-gray-800 transition"
            >
              <Icon size={20} />
              <span>{item.label}</span>
            </button>
          );
        })}
      </nav>
      <button
        onClick={() => {
          logout();
          navigate('/login');
        }}
        className="m-4 flex items-center space-x-3 px-4 py-3 rounded-lg hover:bg-red-600 transition"
      >
        <LogOut size={20} />
        <span>Logout</span>
      </button>
    </aside>
  );
}
