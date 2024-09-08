"use client";

import { useRouter, usePathname } from "next/navigation";

export default function ExtraMenu() {
  const router = useRouter();
  const pathname = usePathname();

  const handleButtonClick = (route: string) => {
    router.push(route);
  };

  const isActiveRoute = (route: string): boolean => pathname === route;

  return (
    <div className="flex flex-col">
      <div className="text-center mb-4">
        <p>Status: ?</p>
        <p>? Players</p>
      </div>

      <button
        className={`w-full mb-4 text-white border-2 rounded-lg px-4 py-2 transition-colors
          ${isActiveRoute("/download") ? "bg-green-500 border-green-500" : "border-green-500"} 
          hover:bg-green-500 hover:border-green-500 hover:text-white
        `}
        onClick={() => handleButtonClick("/download")}
      >
        Download
      </button>

      <button
        className={`w-full mb-4 text-white border-2 rounded-lg px-4 py-2 transition-colors
          ${isActiveRoute("/wiki") ? "bg-blue-500 border-blue-500" : "border-blue-500"} 
          hover:bg-blue-500 hover:border-blue-500 hover:text-white
        `}
        onClick={() => handleButtonClick("/wiki")}
      >
        Wiki
      </button>
    </div>
  );
}
