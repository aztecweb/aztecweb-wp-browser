ARG PHP_VERSION=8.4

FROM php:${PHP_VERSION}-cli-bookworm

ENV COMPOSER_NO_INTERACTION=1 \
    DEBIAN_FRONTEND=noninteractive \
    PATH="/var/www/html/vendor/bin:${PATH}"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        ca-certificates \
        chromium \
        chromium-driver \
        git \
        libfreetype6-dev \
        libicu-dev \
        libjpeg-dev \
        libonig-dev \
        libpng-dev \
        libsqlite3-dev \
        libwebp-dev \
        libxml2-dev \
        libzip-dev \
        sqlite3 \
        unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j"$(nproc)" \
        bcmath \
        dom \
        exif \
        gd \
        intl \
        pdo_sqlite \
        xml \
        zip \
    && apt-get purge -y --auto-remove \
        libfreetype6-dev \
        libicu-dev \
        libjpeg-dev \
        libonig-dev \
        libpng-dev \
        libsqlite3-dev \
        libwebp-dev \
        libxml2-dev \
        libzip-dev \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

RUN adduser --disabled-password --gecos "" --uid 1001 runner \
    && mkdir -p /var/www/html \
    && chown -R runner:runner /var/www/html

USER runner

WORKDIR /var/www/html

CMD ["bash"]
