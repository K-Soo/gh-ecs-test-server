FROM node:20.18.0-alpine AS base
WORKDIR /app
RUN corepack enable && corepack prepare pnpm@latest --activate
COPY pnpm-lock.yaml package.json ./

# Stage - Development
FROM base AS development
RUN pnpm install --frozen-lockfile
COPY . /app
EXPOSE 8000
CMD ["pnpm", "run", "start:dev"]

# production Build Stage
FROM base AS build
RUN pnpm install --frozen-lockfile
COPY . /app
RUN pnpm run build

# Stage - Production 
FROM base AS production
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
RUN rm -f pnpm-lock.yaml package.json
EXPOSE 8000
CMD ["node", "dist/main.js"]

# FROM node:20.18.0-alpine

# WORKDIR /app

# RUN corepack enable && corepack prepare pnpm@latest --activate

# COPY pnpm-lock.yaml ./

# COPY package.json ./

# RUN pnpm install

# COPY . /app

# EXPOSE 5500

# CMD ["npm", "run", "start:dev"]