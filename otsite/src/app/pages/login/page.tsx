"use client";

import { useRouter } from "next/navigation";
import Link from "next/link";
import { useState } from "react";
import { useSnackbar } from "notistack";
import Button from '@mui/material/Button';
import { useAuthContext } from "@/context/authContext";

export default function Login() {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const { updateToken } = useAuthContext();
  const router = useRouter();
  const { enqueueSnackbar } = useSnackbar();

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    
    try {
      const response = await fetch('/api/accounts/loginAccount', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ name: username, password: password }),
      });

      if (response.ok) {
        const data = await response.json();
        await updateToken(data.token);
        enqueueSnackbar(data.message, { variant: 'success' });
        router.push('/accountManagement');
      } else {
        const data = await response.json();
        enqueueSnackbar(data.message, { variant: 'error' });
      }
    } catch (error) {
      enqueueSnackbar("Erro ao realizar login. Por favor, tente novamente.", { variant: 'error' });
    }
  };

  return (
    <div className="flex-row items-center justify-center">
      <div className="w-full mt-4">
        <h1 className="text-xl text-center">Entre com Usuário e Senha!</h1>
      </div>

      <form onSubmit={handleLogin}>
        <div className="m-4">
          <label htmlFor="username" className="block text-sm font-medium text-gray-100">
            Usuário
          </label>
          <input
            id="username"
            name="username"
            type="text"
            required
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            className="px-2 py-1 mt-1 text-gray-700 bg-gray-100 border rounded-lg focus:outline-none focus:ring focus:ring-orange-500"
          />
        </div>

        <div className="m-4">
          <label htmlFor="password" className="block text-sm font-medium text-gray-100">
            Senha
          </label>
          <input
            id="password"
            name="password"
            type="password"
            required
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            className="px-2 py-1 mt-1 text-gray-700 bg-gray-100 border rounded-lg focus:outline-none focus:ring focus:ring-orange-500"
          />
        </div>

        <div className="text-center mt-6">
          <p className="text-sm text-gray-100">
            Não tem uma conta?{" "}
            <Link href="/register" className="text-orange-500 font-extrabold hover:text-orange-700">
              CRIAR CONTA
            </Link>
          </p>
        </div>
        
        <div className="flex justify-end m-4">
          <Button
            type="submit"
            variant="contained"
            color="primary"
            className="px-4 py-2 text-white bg-green-500 rounded-lg hover:bg-green-600 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-1"
          >
            Entrar
          </Button>
        </div>
      </form>
    </div>
  );
}