FROM ubuntu:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y git mysql-server php php-mysql && \
    apt-get clean

# Set MySQL root password
ARG MYSQL_ROOT_PASSWORD=Rabiu2004@
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}

# Set MySQL user and password
ARG MYSQL_USER=rhsalisu
ARG MYSQL_PASSWORD=rabiu2004@
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}

# Set up MySQL configuration
RUN sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Clone the PHP script from GitHub
RUN git clone https://github.com/rabytebuild/wordpressscript.git /var/www/html

# Move Files To Var
RUN cd /var/www/html/wordpressscript
RUN mv * /var/www/html

# Start MySQL service
CMD service mysql start && tail -f /dev/null

# Expose MySQL and HTTP ports
EXPOSE 3306 80
