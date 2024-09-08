# Estágio 1: Construção da aplicação
FROM node:18 AS builder

WORKDIR /app

# Copiar arquivos necessários
COPY package*.json ./

# Instalar dependências e construir a aplicação
RUN npm install
COPY . .
RUN npm run build

# Estágio 2: Imagem para produção
FROM node:18 AS runner

WORKDIR /app

# Copiar apenas o que é necessário
COPY --from=builder /app/.next /app/.next
COPY --from=builder /app/public /app/public
COPY --from=builder /app/package*.json /app/
COPY --from=builder /app/next.config.mjs /app/

# Instalar dependências de produção
RUN npm install --production

# Expor a porta usada pelo Next.js
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["npm", "start"]
