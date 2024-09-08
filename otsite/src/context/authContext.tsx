"use client"

import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import Cookies from 'js-cookie';
import { useRouter } from 'next/navigation';
import { jwtDecode, JwtPayload } from 'jwt-decode';

interface User extends JwtPayload {
  accountId: string;
  accountName: string;
  email: string;
}

interface AuthContextProps {
  user: User | null;
  updateToken: (jwtToken: string) => Promise<void>;
  cleanToken: () => void;
  isAuthenticated: boolean;
  error: string | null;
}

export const AuthContext = createContext<AuthContextProps | undefined>(undefined);

export const AuthProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null);
  const [,setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const router = useRouter();

  useEffect(() => {
    const token = Cookies.get('token');
    if (token) {
      try {
        const decodedToken = jwtDecode<User>(token);
        if (decodedToken.exp && decodedToken.exp * 1000 < Date.now()) {
          cleanToken();
        } else {
          setUser(decodedToken);
        }
      } catch (error) {
        console.error('Token inválido:', error);
        cleanToken(); // Realiza cleanToken no caso de token inválido
      }
    }
    setLoading(false);
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const updateToken = async (jwtToken: string): Promise<void> => {
    setLoading(true);
    setError(null);
    try {
      Cookies.set('token', jwtToken, { expires: 7 });
      const decodedToken = jwtDecode<User>(jwtToken);
      setUser(decodedToken);
      router.push('/');
    } catch (error) {
      console.error('Erro ao realizar updateToken:', error);
      setError('Erro ao realizar updateToken.');
      Cookies.remove('token');
    } finally {
      setLoading(false);
    }
  };

  const cleanToken = (): void => {
    Cookies.remove('token');
    setUser(null);
    router.push('/login');
  };

  return (
    <AuthContext.Provider
      value={{
        user,
        updateToken,
        cleanToken,
        isAuthenticated: !!user,
        error,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};

export const useAuthContext = (): AuthContextProps => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth deve ser usado dentro de um AuthProvider');
  }
  return context;
};