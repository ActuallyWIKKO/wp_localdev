FROM wordpress:latest

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Ensure the container uses the root user to install packages
USER root

# Install required packages
RUN apt-get update && \
    apt-get -y install --no-install-recommends apt-utils dialog sudo && \
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /var/www/html/wp-content/themes/twentytwentytwo && \
    rm -rf /var/www/html/wp-content/themes/twentythree &&\
    rm -rf /var/www/html/wp-content/plugins/hello.php &&\
    rm -rf /var/www/html/wp-content/plugins/askimet   

USER root
WORKDIR /var/www/html
