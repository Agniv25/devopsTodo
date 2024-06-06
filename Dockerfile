# Step 1: Use a node image as the base image
FROM node:16 as build

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Step 4: Install the dependencies
RUN npm install

# Step 5: Copy the rest of the application code to the working directory
COPY . .

# Step 6: Build the React app
RUN npm run build

# Step 7: Use a minimal base image for serving the app
FROM nginx:alpine

# Step 8: Copy the built files from the previous stage to the Nginx server
COPY --from=build /app/build /usr/share/nginx/html

# Step 9: Expose the port Nginx is running on
EXPOSE 80

# Step 10: Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
