"use client"

import PrivateRoute from "@/context/privateRoute";

export default function Download() {
  return (
    <PrivateRoute>
      <div className="flex-row">
        <div className='w-full m-4'>
          <h1 className='text-xl text-center'>Download Page</h1>
          <h2 className='text-sm m-2'>OTserver based on Naruto Anime.</h2>
        </div>
      </div>
    </PrivateRoute>
  );
}
