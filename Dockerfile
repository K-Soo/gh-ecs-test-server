FROM node:20.18.0-alpine

WORKDIR /app

RUN corepack enable && corepack prepare pnpm@latest --activate

COPY pnpm-lock.yaml ./

COPY package.json ./

RUN pnpm install

COPY . /app

EXPOSE 5500

CMD ["npm", "run", "start:dev"]