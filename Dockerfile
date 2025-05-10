# Use Node 20 Alpine base image for smaller size and fewer vulnerabilities
FROM node:20

# Create app directory
WORKDIR /app

# Install build dependencies
RUN apk add --no-cache python3 make g++ git openssh-client

# For node-pty specifically
RUN apk add --no-cache linux-headers eudev-dev

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies with verbose output for node-pty
RUN npm install --build-from-source --verbose

# Add type module to package.json if needed (based on warning)
RUN if grep -q "type" package.json; then echo "type already specified"; else sed -i 's/{"name":/{"type":"module","name":/g' package.json || echo '{"type":"module"}' >> package.json; fi

# Copy app files
COPY . .

# Expose your port
EXPOSE 3001

# Start the app
CMD ["node", "index.js"]