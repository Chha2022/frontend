# Stage 1: Build the application
FROM node:latest as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY ./ ./
RUN npm run build

# Stage 2: Serve the application with Nginx
FROM nginx as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/nginx.conf

# Expose the default Nginx port
EXPOSE 80
