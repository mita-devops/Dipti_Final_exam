# Use an official Node.js runtime as the base image
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install --frozen-lockfile

# Copy the source code and build the React app
COPY . .
RUN npm run build

# Use a lightweight web server to serve the built files
FROM nginx:alpine

# Copy built React app to Nginx's public directory
COPY --from=builder /app/build /usr/share/nginx/html

# Expose the port Nginx runs on
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]