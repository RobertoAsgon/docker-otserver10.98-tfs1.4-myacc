import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";

import ClientLayout from "./clientLayout";
import Header from "@/components/Header/Header";
import { AuthProvider } from "@/context/authContext";
import NavMenu from "@/components/NavMenu/NavMenu";
import ExtraMenu from "@/components/ExtraMenu/ExtraMenu";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "NTO Online",
  description: "OTserver based on NTO Anime.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body
        className={`${inter.className} w-full min-h-screen flex flex-col items-center justify-start gap-4`}
        style={{
          backgroundImage: "url('/bg-konoha-large.svg')",
          backgroundSize: "cover",
          backgroundPosition: "center",
          backgroundRepeat: "no-repeat",
          backgroundAttachment: "fixed",
          minHeight: "100vh",
        }}
      >
        <header className="w-[1180px] h-[124px]">
          <Header />
        </header>
        <AuthProvider>
          <ClientLayout>
            <main className="flex w-[1180px] gap-4">
              <article className="w-[324px]">
                <NavMenu />
              </article>
              <section className="w-full border mb-[224px] border-blue-500 bg-slate-800 opacity-80 rounded-md">
                {children}
              </section>
              <article className="w-[324px]">
                <ExtraMenu />
              </article>
            </main>
          </ClientLayout>
        </AuthProvider>
      </body>
    </html>
  );
}
