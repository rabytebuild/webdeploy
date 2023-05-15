FROM php:7.4-apache

# Install dependencies
RUN apt-get update && apt-get install -y git

# Set the working directory
WORKDIR /var/www/html

# Clone the PHP script from GitHub
RUN git clone https://github.com/rabytebuild/wordpressscript

# Set appropriate file permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache service
CMD ["apache2-foreground"]
