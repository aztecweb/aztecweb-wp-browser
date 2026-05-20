ARG PHP_VERSION=8.4

FROM php:${PHP_VERSION}-cli-alpine

ENV COMPOSER_NO_INTERACTION=1 \
    PATH="/var/www/html/vendor/bin:${PATH}"

RUN apk add --no-cache \
        bash \
        chromium \
        chromium-chromedriver \
        freetype \
        freetype-dev \
        git \
        icu-dev \
        icu-libs \
        libjpeg-turbo \
        libjpeg-turbo-dev \
        libpng \
        libpng-dev \
        libwebp \
        libwebp-dev \
        libxml2 \
        libxml2-dev \
        libzip \
        libzip-dev \
        oniguruma \
        oniguruma-dev \
        sqlite \
        sqlite-dev \
        sqlite-libs \
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
    && apk del --no-cache \
        freetype-dev \
        icu-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
        libxml2-dev \
        libzip-dev \
        oniguruma-dev \
        sqlite-dev

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

RUN adduser -D -g "" -u 1001 runner \
    && mkdir -p /var/www/html \
    && chown -R runner:runner /var/www/html

USER runner

WORKDIR /var/www/html

CMD ["bash"]
