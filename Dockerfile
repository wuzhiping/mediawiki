FROM mediawiki:latest

USER root

RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    make \
    && rm -rf /var/lib/apt/lists/*

RUN cd /usr/local/etc/php && \
    docker-php-ext-configure pgsql --with-pgsql=/usr && \
    docker-php-ext-install -j$(nproc) pgsql pdo_pgsql

USER www-data
