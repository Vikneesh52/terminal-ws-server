# Use Node 20 Alpine base image for smaller size and fewer vulnerabilities
FROM node:20-alpine

# Install build tools
RUN apt-get update && \
    apt-get install -y python3 make g++ && \
    apt-get clean

WORKDIR /app

# Copy only package files first (cache npm install step)
COPY package*.json ./

# Force a clean install (no prebuilt node_modules)
RUN npm install --build-from-source

# Then copy rest of the app
COPY . .

EXPOSE 3001

CMD ["node", "index.js"]