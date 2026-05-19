ARG PHP_VERSION=8.4

FROM php:${PHP_VERSION}-cli-alpine

ARG WP_HOME=http://localhost:8080
ARG WP_TITLE="AztecWP Browser Test Site"
ARG WP_ADMIN_USER=admin
ARG WP_ADMIN_PASSWORD=password
ARG WP_ADMIN_EMAIL=admin@example.com

ENV WP_CLI_ALLOW_ROOT=1 \
    COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_NO_INTERACTION=1 \
    WP_HOME=${WP_HOME}

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

RUN curl -sSL -o /usr/local/bin/wp \
        https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

WORKDIR /var/www/html

COPY composer.json composer.lock* ./

RUN composer install --no-progress --no-interaction --prefer-dist

COPY . .

RUN cp public/packages/plugins/sqlite-database-integration/db.copy \
        public/packages/db.php \
    && DB_HOST=localhost WP_HOME="${WP_HOME}" wp core install \
        --url="${WP_HOME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
    && wp plugin activate woocommerce \
    && wp plugin activate sqlite-database-integration \
    && wp theme activate storefront \
    && wp wc hpos sync \
    && wp wc hpos enable \
    && wp wc hpos sync \
    && wp wc hpos disable

EXPOSE 8080

CMD ["vendor/bin/codecept", "run"]
