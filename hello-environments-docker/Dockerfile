# Dockerfile
FROM node:18-alpine

# Create directory
WORKDIR /app

# Copy server
COPY app.js .

# Install dependencies
RUN npm install express

# Expose port
EXPOSE 3000

# Command
CMD ["node", "app.js"]
