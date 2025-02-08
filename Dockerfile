# Use PHP and Nginx
FROM php:8.2-fpm

# Install Nginx
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /usr/share/nginx/html/

# Remove default index files
RUN rm -rf /usr/share/nginx/html/*

# Copy app files into container
COPY app/. /usr/share/nginx/html/

# Set permissions (fix 403 error)
RUN chown -R www-data:www-data /usr/share/nginx/html/ \
    && chmod -R 755 /usr/share/nginx/html/

# Copy custom Nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start both Nginx & PHP-FPM
CMD service php-fpm start && nginx -g "daemon off;"
