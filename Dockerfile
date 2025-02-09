# Use PHP 8.2 with Apache
FROM php:8.2-apache

# Install required PHP extensions
RUN apt-get update && apt-get install -y \
    libonig-dev \
    && docker-php-ext-install pdo pdo_mysql mysqli \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /var/www/html/

# Remove default index files
RUN rm -rf /var/www/html/*

# Copy app files into container
COPY app/. /var/www/html/

# Set permissions (fix 403 error)
RUN chown -R www-data:www-data /var/www/html/ \
    && chmod -R 755 /var/www/html/

# Enable Apache mod_rewrite (if needed for .htaccess)
RUN a2enmod rewrite

# Expose port 80
EXPOSE 80

# Start Apache in foreground
CMD ["apache2-foreground"]
