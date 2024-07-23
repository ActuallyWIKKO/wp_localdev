FROM wordpress:latest

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Ensure the container uses the root user to install packages
USER root

# Install required packages
RUN apt-get update && \
    apt-get -y install --no-install-recommends apt-utils dialog sudo libzip4 libzip-dev libwebp-dev libfreetype-dev libjpeg62-turbo-dev libpng-dev unzip zip git && \
    rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure gd --with-freetype --with-webp --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd bcmath exif mysqli pdo pdo_mysql zip sockets 

USER root
WORKDIR /var/www/html