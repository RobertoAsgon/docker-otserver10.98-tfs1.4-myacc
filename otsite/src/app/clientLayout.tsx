"use client";

import * as React from 'react';
import { SnackbarProvider } from 'notistack';

export default function ClientLayout({ children }: { children: React.ReactNode }) {
  return (
    <SnackbarProvider maxSnack={5}>
      {children}
    </SnackbarProvider>
  );
}
