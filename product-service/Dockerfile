# Base image with nodejs
FROM node:16

# Creating a work directory
WORKDIR /app

# copy package.json and install packages
COPY package.json .
RUN npm install

# copy application code 
COPY app.js . 

# Expose port 3000
EXPOSE 3000

# Run the app
CMD ["node", "app.js"]

