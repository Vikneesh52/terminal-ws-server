# Use Node 20 Alpine base image for smaller size and fewer vulnerabilities
FROM node:20-alpine

# Create app directory
WORKDIR /app

# Install build dependencies before npm install
RUN apk add --no-cache python3 make g++ 

# Copy package.json and package-lock.json (or yarn.lock) to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm install

# Optionally remove build dependencies to reduce image size
# (only do this if you're sure they won't be needed at runtime)
# RUN apk del python3 make g++

# Copy app files
COPY . .

# Expose your port
EXPOSE 3001

# Start the app
CMD ["node", "index.js"]