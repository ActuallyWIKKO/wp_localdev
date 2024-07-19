FROM wordpress:latest

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Ensure the container uses the root user to install packages
USER root

# Install necessary packages
RUN apt-get update && apt-get -y install --no-install-recommends apt-utils dialog

# Install additional packages
RUN apt-get -y install git iproute2 procps lsb-release sudo

# Install and configure xdebug
RUN pecl install xdebug || true && \
    docker-php-ext-enable xdebug && \
    echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug.ini

# Add vscode user and group if they do not exist
RUN groupadd -f --gid 1000 vscode && \
    id -u vscode &>/dev/null || useradd -s /bin/bash --uid 1000 --gid 1000 -m vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vscode && \
    chmod 0440 /etc/sudoers.d/vscode

# Cleanup
RUN apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

USER vscode
WORKDIR /var/www/html
