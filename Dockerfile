# Switch to Debian-based image which has better compatibility with native modules
FROM node:20-slim

# Create app directory
WORKDIR /app

# Install build dependencies
RUN apt-get update && \
    apt-get install -y python3 make g++ git openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies with rebuild
RUN npm install --verbose

# Copy app files
COPY . .

# Expose your port
EXPOSE 3001

# Start the app
CMD ["node", "index.js"]