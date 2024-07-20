FROM wordpress:latest

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Ensure the container uses the root user to install packages
USER root

# Install PHP extensions and Apache modules
RUN apt-get update && apt-get install -y \
    # libjpeg-dev \
    # libpng-dev \
    # libfreetype6-dev \
    # libwebp-dev \
    libmariadb-dev \
    sudo \
    # && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    # && docker-php-ext-install gd mysqli \
    # && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Set ServerName to localhost to avoid Apache warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html/wp-content/* \
    && chmod -R 755 /var/www/html/wp-content/*

# # # Switch to www-data user
# USER www-data

# # Remove inactive plugins
# RUN echo "Removing inactive plugins" 

# RUN wp plugin delete --all --path=/var/www/html
# && wp theme delete --all --path=/var/www/html \
# && wp theme install https://github.com/ActuallyWIKKO/wikko_dev_headless/archive/refs/heads/main.zip --path=/var/www/html \
# && wp theme activate wikko_dev_headless --path=/var/www/html


WORKDIR /var/www/html