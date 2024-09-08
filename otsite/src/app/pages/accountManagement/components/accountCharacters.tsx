"use client";

import React, { useEffect, useState } from 'react';
import CircularProgress from '@mui/material/CircularProgress';
import Cookies from 'js-cookie';
import { vocations } from './createCharacter';
import { useAuthContext } from '@/context/authContext';

export interface Character {
  id: number;
  name: string;
  vocation: number;
  level: number;
}

interface AccountCharactersProps {
  characters: Character[];
  setCharacters: React.Dispatch<React.SetStateAction<Character[]>>;
}

export default function AccountCharacters({ characters, setCharacters }: AccountCharactersProps) {
  const { user } = useAuthContext();
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchCharacters = async () => {
      if (!user?.accountId) return;

      try {
        const response = await fetch(`/api/players/accountPlayers?accountId=${user.accountId}`, {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${Cookies.get('token')}`,
          },
        });

        if (response.ok) {
          const data = await response.json();
          setCharacters(data.players);
        } else {
          console.error('Erro ao buscar personagens:', response.statusText);
        }
      } catch (error) {
        console.error("Erro ao buscar personagens:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchCharacters();
  }, [user?.accountId, setCharacters]);

  const getVocationImage = (vocationId: number) => {
    const vocation = vocations.find((vocation) => vocation.id === vocationId);
    return vocation ? vocation.path_img : '';
  };

  return (
    <div className="m-4 w-auto">
      {loading ? (
        <div className="flex justify-center items-center">
          <CircularProgress size={24} color="inherit" />
        </div>
      ) : characters.length === 0 ? (
        <div className="flex flex-col items-center justify-center text-gray-400">
          <p className="text-lg">Nenhum personagem encontrado.</p>
          <p className="text-sm">Crie um novo personagem para começar sua jornada!</p>
        </div>
      ) : (
        <div className="max-h-[288px] overflow-y-auto scrollbar-thin scrollbar-thumb-gray-500 scrollbar-thumb-rounded scrollbar-track-transparent space-y-2">
          {characters.map((character) => (
            <div key={character.id} className="flex items-center justify-between border rounded-lg bg-gray-800 text-white p-2">
              <img
                src={getVocationImage(character.vocation)}
                alt={`Vocation ${character.vocation}`}
                className="w-12 h-12"
              />
              <h3 className="text-md font-bold">{character.name}</h3>
              <div className='flex flex-col'>
                <p className="text-sm">{vocations.find(v => v.id === character.vocation)?.name}</p>
                <p className="text-sm">Level: {character.level}</p>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
