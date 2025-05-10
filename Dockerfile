# Use Node 20 Alpine base image for smaller size and fewer vulnerabilities
FROM node:20-alpine

# Create app directory
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock) to leverage Docker cache
COPY package*.json ./

RUN npm install --build-from-source

RUN apk update && \
    apk add --no-cache python3 make g++ && \
    npm install && \
    apk del python3 make g++

# Copy app files
COPY . .

# Expose your port
EXPOSE 3001

# Start the app
CMD ["node", "index.js"]
