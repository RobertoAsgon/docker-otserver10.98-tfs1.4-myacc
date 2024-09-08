import React, { ReactNode, useEffect, useRef } from 'react';
import { useRouter } from 'next/navigation';
import { enqueueSnackbar } from 'notistack';
import { useAuthContext } from './authContext';

interface PrivateRouteProps {
  children: ReactNode;
}

const PrivateRoute: React.FC<PrivateRouteProps> = ({ children }) => {
  const { isAuthenticated } = useAuthContext();
  const router = useRouter();
  const hasRedirectedRef = useRef(false);

  useEffect(() => {
    if (!isAuthenticated && !hasRedirectedRef.current) {
      enqueueSnackbar("Por favor, faça login para acessar esta página.", { variant: "warning" });
      router.push('/login');
      hasRedirectedRef.current = true;
    }
  }, [isAuthenticated, router]);

  return isAuthenticated ? <>{children}</> : null;
};

export default PrivateRoute;
