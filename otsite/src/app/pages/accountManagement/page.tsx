"use client";

import { useAuthContext } from '@/context/authContext';
import React, { useState } from 'react';
import AccountCharacters, { Character } from './components/accountCharacters';
import PrivateRoute from '@/context/privateRoute';
import CreateCharacter from './components/createCharacter';


export default function AccountManagement() {
  const { cleanToken } = useAuthContext();
  const [characters, setCharacters] = useState<Character[]>([]);

  const handleCharacterCreated = (newCharacter: Character) => {
    setCharacters(prevCharacters => [...prevCharacters, newCharacter]);
  };

  return (
    <PrivateRoute>
      <div className="flex flex-col">
        <div className="w-full mt-4">
          <h1 className="text-xl text-center">Gerencie sua Conta!</h1>
        </div>

        <div className="flex justify-between m-4 mb-0">
          <h2 className="text-lg mb-4">Seus Personagens</h2>
          <button
            className="px-4 py-2 h-[40px] text-white bg-red-500 rounded-lg hover:bg-red-600 focus:outline-none focus:ring-1 focus:ring-red-500 focus:ring-offset-1"
            onClick={cleanToken}
          >
            Deslogar
          </button>
        </div>

        <AccountCharacters characters={characters} setCharacters={setCharacters} /> 

        <CreateCharacter onCharacterCreated={handleCharacterCreated} />
      </div>
    </PrivateRoute>
  );
}
