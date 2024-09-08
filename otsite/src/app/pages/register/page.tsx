"use client";

import { useState } from "react";
import { useSnackbar } from "notistack";
import CircularProgress from '@mui/material/CircularProgress';
import Button from '@mui/material/Button';

export default function Register() {
  const [username, setUsername] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const { enqueueSnackbar } = useSnackbar();

  const handleRegister = async (e: React.FormEvent) => {
    e.preventDefault();

    if (password !== confirmPassword) {
      enqueueSnackbar("As senhas não coincidem.", { variant: "warning" });
      return;
    }

    if (!username || !email || !password) {
      enqueueSnackbar("Preencha todos os campos.", { variant: "warning" });
      return;
    }

    setLoading(true);

    try {
      const response = await fetch("/api/accounts/register", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ name: username, email, password }),
      });

      const data = await response.json();

      if (response.ok) {
        enqueueSnackbar(data.message, { variant: "success" });
        // Redirecionar para a página de login ou outra página após o sucesso
      } else {
        const errorMessages = data.message.split(',').map((msg: string) => msg.trim());
        errorMessages.forEach((msg: string) => enqueueSnackbar(msg, { variant: "error" }));
      }
    } catch (error) {
      enqueueSnackbar("Erro ao criar conta. Por favor, tente novamente.", { variant: "error" });
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="flex-row items-center justify-center">
      <div className="w-full mt-4">
        <h1 className="text-xl text-center">Crie sua Conta!</h1>
      </div>

      <form onSubmit={handleRegister}>
        <div className="flex m-4 gap-4">
          <div className="w-1/2">
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
              className="w-full px-2 py-1 mt-1 text-gray-700 bg-gray-100 border rounded-lg focus:outline-none focus:ring focus:ring-orange-500"
            />
          </div>
          <div className="w-1/2">
            <label htmlFor="email" className="block text-sm font-medium text-gray-100">
              Email
            </label>
            <input
              id="email"
              name="email"
              type="email"
              required
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full px-2 py-1 mt-1 text-gray-700 bg-gray-100 border rounded-lg focus:outline-none focus:ring focus:ring-orange-500"
            />
          </div>
        </div>

        <div className="flex m-4 gap-4">
          <div className="w-1/2">
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
              className="w-full px-2 py-1 mt-1 text-gray-700 bg-gray-100 border rounded-lg focus:outline-none focus:ring focus:ring-orange-500"
            />
          </div>
          <div className="w-1/2">
            <label htmlFor="confirmPassword" className="block text-sm font-medium text-gray-100">
              Confirme a Senha
            </label>
            <input
              id="confirmPassword"
              name="confirmPassword"
              type="password"
              required
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              className="w-full px-2 py-1 mt-1 text-gray-700 bg-gray-100 border rounded-lg focus:outline-none focus:ring focus:ring-orange-500"
            />
          </div>
        </div>

        <div className="flex justify-end m-4">
          <Button
            type="submit"
            variant="contained"
            color="primary"
            disabled={loading}
            className={`px-4 py-2 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-1 ${loading ? "bg-green-400 cursor-not-allowed" : "bg-green-500 hover:bg-green-600"}`}
          >
            {loading ? <CircularProgress size={24} color="inherit" /> : "Cadastrar"}
          </Button>
        </div>
      </form>
    </div>
  );
}
