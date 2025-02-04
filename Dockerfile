# Use the official Nginx base image
FROM nginx:latest

# Set the working directory inside the container
WORKDIR /var/www/html

# Remove default Nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy the static website files into the correct Nginx directory
COPY . /var/www/html

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
