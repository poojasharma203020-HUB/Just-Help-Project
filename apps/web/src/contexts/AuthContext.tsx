import React, { createContext, useContext, useState, useEffect } from 'react';
import { User } from '@supabase/supabase-js';
import { supabase } from '../lib/supabase';

interface AuthContextType {
  user: User | null;
  loading: boolean;
  error: string | null;
  login: (email: string, password: string) => Promise<void>;
  logout: () => Promise<void>;
  signup: (email: string, password: string) => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const checkAuth = async () => {
      try {
        const { data } = await supabase.auth.getSession();
        setUser(data.session?.user ?? null);
      } catch (err) {
        setError('Failed to check authentication');
      } finally {
        setLoading(false);
      }
    };

    checkAuth();

    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      (event, session) => {
        setUser(session?.user ?? null);
      }
    );

    return () => subscription?.unsubscribe();
  }, []);

  const login = async (email: string, password: string) => {
    try {
      setError(null);
      const { error: err } = await supabase.auth.signInWithPassword({
        email,
        password,
      });
      if (err) throw err;
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Login failed');
      throw err;
    }
  };

  const logout = async () => {
    try {
      setError(null);
      const { error: err } = await supabase.auth.signOut();
      if (err) throw err;
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Logout failed');
      throw err;
    }
  };

  const signup = async (email: string, password: string) => {
    try {
      setError(null);
      const { error: err } = await supabase.auth.signUp({
        email,
        password,
      });
      if (err) throw err;
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Signup failed');
      throw err;
    }
  };

  return (
    <AuthContext.Provider value={{ user, loading, error, login, logout, signup }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within AuthProvider');
  }
  return context;
}
