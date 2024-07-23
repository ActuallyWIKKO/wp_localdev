FROM wordpress:latest

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Ensure the container uses the root user to install packages
USER root

# Install required packages
RUN apt-get update && \
    apt-get -y install --no-install-recommends apt-utils dialog sudo libzip4 libzip-dev libwebp-dev libfreetype-dev libjpeg62-turbo-dev libpng-dev unzip zip git nano curl && \
    rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure gd --with-freetype --with-webp --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd bcmath exif mysqli pdo pdo_mysql zip sockets 
RUN a2enmod headers proxy proxy_http rewrite
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
USER root
WORKDIR /var/www/html