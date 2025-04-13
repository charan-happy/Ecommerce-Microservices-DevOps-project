# Base image with Node.js (using a specific version for stability)
FROM node:16.19.0-bullseye-slim

# Create app directory
WORKDIR /app

# Copy package.json and package-lock.json for dependency installation
COPY package*.json ./

# Install only production dependencies
RUN npm ci --only=production

# Copy application code
COPY . .

# Expose port 3000
EXPOSE 3000

# Set environment variables (optional)
# ENV NODE_ENV=production

# Run the app
CMD ["node", "app.js"]

