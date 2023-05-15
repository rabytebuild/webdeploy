FROM php:7.4-apache

# Install dependencies
RUN apt-get update && apt-get install -y git

# Set the working directory
WORKDIR /var/www/html

# Clone the PHP script from GitHub
RUN git clone https://github.com/rabytebuild/wordpressscript.git .

# Copy the contents of the wordPressscript directory to /var/www/html
COPY wordpressscript/. /var/www/html

# Set the appropriate file permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port 80
EXPOSE 80

# Start Apache service
CMD ["apache2-foreground"]
