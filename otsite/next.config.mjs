/** @type {import('next').NextConfig} */
const nextConfig = {
async rewrites() {
    return [
    {
        source: '/:path*', // Mapeia tudo o que está sob "/pages"
        destination: '/pages/:path*', // Redireciona para a pasta "pages"
    },
    ];
},
};
  
export default nextConfig;
  