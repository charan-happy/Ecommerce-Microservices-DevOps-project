# Base image with Node.js (using a specific version for stability)
FROM node:16.19.0-bullseye-slim

# Create app directory
WORKDIR /app

# Copy package.json and package-lock.json for dependency installation
COPY package*.json ./

# Install 
RUN npm install

# Copy application code
COPY . .

COPY public/ ./public/

# Expose port 3000
EXPOSE 3000

# Run the app
CMD ["node", "app.js"]

