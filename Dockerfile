FROM node:18-alpine as build

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Build the application
RUN npm run build

# Prepare the production image
FROM node:18-alpine as prod

# Set the working directory in the container
WORKDIR /app

# Copy the built application from the "build" image into the "prod" image
COPY --from=build /app/.output /app/.output

# Expose the port that the app runs on
EXPOSE 3000

# Start is the same as before
CMD ["node", ".output/server/index.mjs"]
