# Step 1: Build the React app with Vite
FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build   # This will create /app/dist

# Step 2: Serve the built files using Nginx
FROM nginx:alpine

# Copy Vite build output (dist) instead of build
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
