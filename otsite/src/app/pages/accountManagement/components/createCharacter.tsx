"use client";

import { useState } from "react";
import { useSnackbar } from "notistack";
import CircularProgress from '@mui/material/CircularProgress';
import Cookies from 'js-cookie';
import { Character } from "./accountCharacters";

export const vocations = [
  { id: 1, name: "Naruto", path_img: "/perso_imgs/naruto.png" },
  { id: 2, name: "Sasuke", path_img: "/perso_imgs/sasuke.png" },
  { id: 3, name: "Sakura", path_img: "/perso_imgs/sakura.png" },
  { id: 4, name: "Rock Lee", path_img: "/perso_imgs/lee.png" },
  { id: 5, name: "Neji", path_img: "/perso_imgs/neji.png" },
  { id: 6, name: "Tenten", path_img: "/perso_imgs/tenten.png" },
  { id: 7, name: "Kiba", path_img: "/perso_imgs/kiba.png" },
  { id: 8, name: "Hinata", path_img: "/perso_imgs/hinata.png" },
  { id: 9, name: "Shino", path_img: "/perso_imgs/shino.png" },
  { id: 10, name: "Shikamaru", path_img: "/perso_imgs/shikamaru.png" },
  { id: 11, name: "Ino", path_img: "/perso_imgs/ino.png" },
  { id: 12, name: "Chouji", path_img: "/perso_imgs/chouji.png" },
];

interface CreateCharacterProps {
  onCharacterCreated: (character: Character) => void;
}

export default function CreateCharacter({ onCharacterCreated }: CreateCharacterProps) {
  const [characterName, setCharacterName] = useState("");
  const [selectedVocation, setSelectedVocation] = useState<number | null>(null);
  const [loading, setLoading] = useState(false);
  const { enqueueSnackbar } = useSnackbar();

  const handleCreateCharacter = async () => {
    if (!characterName || selectedVocation === null) {
      enqueueSnackbar("Por favor, preencha o nome e selecione uma vocação.", { variant: "warning" });
      return;
    }

    setLoading(true);

    try {
      const response = await fetch('/api/players/createPlayer', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${Cookies.get('token')}`, 
        },
        body: JSON.stringify({
          name: characterName,
          vocation: selectedVocation,
        }),
      });

      const data = await response.json();

      if (response.ok) {
        enqueueSnackbar(data.message, { variant: 'success' });
        onCharacterCreated({
          id: data.id, // Supondo que o ID seja retornado na resposta
          name: characterName,
          vocation: selectedVocation,
          level: 1, // Assumindo que o nível inicial seja 1
        });
      } else {
        const errorMessages = data.message.split(',').map((msg: string) => msg.trim());
        errorMessages.forEach((msg: string) => enqueueSnackbar(msg, { variant: 'error' }));
      }
    } catch (error) {
      enqueueSnackbar("Erro. Por favor, tente novamente.", { variant: "error" });
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="flex flex-col">
      <div className="flex m-4 mb-2 gap-4">
        <div className="flex-row">
          <h2 className="text-base">Crie um novo personagem:</h2>
          <label
            htmlFor="username"
            className="block text-sm font-medium text-gray-100"
          >
            Nome do seu novo Personagem:
          </label>
          <input
            id="username"
            name="username"
            type="text"
            value={characterName}
            onChange={(e) => setCharacterName(e.target.value)}
            required
            className="px-2 py-1 mt-1 w-[234px] text-gray-700 bg-gray-100 border rounded-lg focus:outline-none focus:ring focus:ring-orange-500"
          />
        </div>
        <div className="max-h-[300px] overflow-y-auto scrollbar-thin scrollbar-thumb-gray-500 scrollbar-thumb-rounded scrollbar-track-transparent">
          <div className="flex flex-wrap justify-around gap-2">
            {vocations.map((vocation) => (
              <label
                key={vocation.id}
                className="cursor-pointer group flex justify-center flex-col items-center rounded-md w-24 h-24 hover:bg-gray-200"
              >
                <img
                  src={vocation.path_img}
                  alt={vocation.name}
                  className="w-16 h-16 mt-1"
                />
                <div className="flex items-center justify-center gap-2">
                  <input
                    type="radio"
                    name="vocation"
                    value={vocation.id}
                    onChange={() => setSelectedVocation(vocation.id)}
                    className="form-radio text-blue-600"
                  />
                  <span className="text-sm text-white font-extrabold group-hover:text-black">
                    {vocation.name}
                  </span>
                </div>
              </label>
            ))}
          </div>
        </div>
      </div>

      <div className="flex justify-end">
        <button
          onClick={handleCreateCharacter}
          disabled={loading}
          className={`m-4 flex items-center justify-center gap-2 px-4 py-2 rounded-lg focus:outline-none focus:ring-1 focus:ring-green-500 focus:ring-offset-1
            ${loading ? 'bg-green-400 cursor-not-allowed text-white' : 'bg-green-500 hover:bg-green-600 text-white'}`}
        >
          {loading && <CircularProgress size={18} color="inherit" />}
          Criar Personagem
        </button>
      </div>
    </div>
  );
}
