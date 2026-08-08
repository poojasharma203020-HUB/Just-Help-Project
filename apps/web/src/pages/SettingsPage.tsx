import React from 'react';
import { Sidebar } from '../components/Sidebar';

export function SettingsPage() {
  return (
    <div className="flex">
      <Sidebar />
      <main className="flex-1 bg-gray-50 p-8">
        <h1 className="text-3xl font-bold mb-8">Settings</h1>
        <div className="bg-white p-6 rounded-lg shadow">
          <p className="text-gray-600">Settings interface coming soon...</p>
        </div>
      </main>
    </div>
  );
}
