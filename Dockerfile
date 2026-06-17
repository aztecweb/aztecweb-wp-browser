ARG PHP_VERSION=8.4
ARG RUNNER_UID=1001
ARG RUNNER_GID=1001

FROM php:${PHP_VERSION}-cli-alpine

ARG RUNNER_UID
ARG RUNNER_GID

# Chromium/chromedriver versions are determined by the base image's Alpine
# release, and the two packages must match each other. Pin them explicitly per
# PHP variant so the browser version is reproducible and visible instead of
# silently tracking the base Alpine (php8.0/Alpine3.16 -> Chromium 102,
# php8.4/Alpine -> latest Chromium version). The build matrix passes 
# CHROMIUM_VERSION per variant; it must exist in that base Alpine's community
# repo (verify with `apk policy chromium`). Leave empty to take the repo
# default.
ARG CHROMIUM_VERSION=

ENV COMPOSER_NO_INTERACTION=1 \
    COMPOSER_HOME=/tmp/composer \
    HOME=/tmp \
    PATH="/var/www/html/vendor/bin:${PATH}"

RUN apk add --no-cache \
        bash \
        "chromium${CHROMIUM_VERSION:+=$CHROMIUM_VERSION}" \
        "chromium-chromedriver${CHROMIUM_VERSION:+=$CHROMIUM_VERSION}" \
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
        procps \
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
        mysqli \
        pdo_sqlite \
        xml \
        zip \
    && apk del \
        freetype-dev \
        icu-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
        libxml2-dev \
        libzip-dev \
        oniguruma-dev \
        sqlite-dev

RUN printf 'error_reporting = E_ALL & ~E_DEPRECATED & ~E_USER_DEPRECATED\n' \
    > /usr/local/etc/php/conf.d/error-reporting.ini

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

# Default identity bakes in UID/GID for CI parity. Callers running on hosts
# with a different UID/GID must pass `docker run --user $(id -u):$(id -g)`
# (the bin/test wrapper does this automatically). HOME/COMPOSER_HOME point
# at /tmp so arbitrary UIDs have a writable cache dir.
RUN addgroup -g "${RUNNER_GID}" runner \
    && adduser -D -g "" -u "${RUNNER_UID}" -G runner runner \
    && mkdir -p /var/www/html /tmp/composer \
    && chown -R runner:runner /var/www/html \
    && chmod 1777 /tmp/composer

USER runner

WORKDIR /var/www/html

CMD ["bash"]
