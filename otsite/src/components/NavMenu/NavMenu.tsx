"use client";

import { useAuthContext } from "@/context/authContext";
import { useRouter, usePathname } from "next/navigation";
import React from "react";

export default function NavMenu() {
  const router = useRouter();
  const pathname = usePathname();
  const { user } = useAuthContext();

  const handleButtonClick = (route: string) => {
    router.push(route);
  };

  const isActiveRoute = (route: string): boolean => pathname === route;

  const getButtonClasses = (route: string) => {
    const isActive = isActiveRoute(route);
    return `
      w-full 
      font-naruto
      text-white 
      border 
      rounded-lg 
      px-4 
      py-2 
      transition-colors 
      ${isActive ? "bg-orange-500 border-orange-500" : "border-orange-500"} 
      hover:bg-orange-500 hover:border-orange-500 hover:text-white 
    `;
  };

  const textShadowStyle = {
    textShadow: '1px 1px 1px #000000 , -1px -1px 1px #000000 , 1px -1px 1px #000000 , -1px 1px 1px #000000 ',
  };

  return (
    <div className="flex flex-col gap-4 text-lg">
      <button
        className={getButtonClasses("/")}
        onClick={() => handleButtonClick("/")}
        style={textShadowStyle}
      >
        Inicio
      </button>

      <button
        className={getButtonClasses(user?.accountId ? "/accountManagement" : "/login")}
        onClick={() => handleButtonClick(user?.accountId ? "/accountManagement" : "/login")}
        style={textShadowStyle}
      >
        {user?.accountId ? "Gerenciar Conta" : "Login"}
      </button>

      <button
        className={getButtonClasses("/searchPlayer")}
        onClick={() => handleButtonClick("/searchPlayer")}
        style={textShadowStyle}
      >
        Investigar
      </button>

      <button
        className={getButtonClasses("/donate")}
        onClick={() => handleButtonClick("/donate")}
        style={textShadowStyle}
      >
        Donate
      </button>
    </div>
  );
}
