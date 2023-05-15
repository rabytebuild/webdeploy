FROM php:7.4-apache

# Install dependencies
RUN apt-get update && \
    apt-get install -y git libpq-dev && \
    docker-php-ext-install pdo_mysql

# Set the working directory
WORKDIR /var/www/html

# Clone the PHP script from GitHub
RUN git clone https://github.com/rabytebuild/wordpressscript.git

# Moving Directory to Back
RUN cd wordpressscript
RUN mv * ..

# Set appropriate file permissions
RUN chown -R www-data:www-data /var/www/html

# Configure PHP and Apache for MySQL connection
COPY php.ini /usr/local/etc/php/conf.d/custom.ini
RUN docker-php-ext-enable pdo_mysql

# Enable Apache modules and configure the site
RUN a2enmod rewrite
COPY apache.conf /etc/apache2/sites-available/000-default.conf

# Expose port 80
EXPOSE 80

# Start Apache service
CMD ["apache2-foreground"]
