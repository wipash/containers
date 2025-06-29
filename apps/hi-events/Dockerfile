# Stage 1: Build assets and dependencies
FROM node:20-alpine AS builder

ARG VERSION
ARG TARGETPLATFORM

# Install build dependencies
RUN apk add --no-cache git yarn php php-intl php-dom composer

# Clone the repository
WORKDIR /src
RUN git clone https://github.com/HiEventsDev/Hi.Events.git . \
    && if [ -n "$VERSION" ]; then git checkout "v${VERSION}"; fi

# Build the frontend
WORKDIR /src/frontend
RUN yarn install --frozen-lockfile && yarn build

# Install backend dependencies
WORKDIR /src/backend
RUN composer install --ignore-platform-reqs --no-interaction --no-dev --optimize-autoloader --prefer-dist

# Stage 2: Final image
FROM serversideup/php:beta-8.3.2-fpm-alpine

ARG VERSION
ARG TARGETPLATFORM

LABEL org.opencontainers.image.source="https://github.com/HiEventsDev/Hi.Events"

ENV PHP_OPCACHE_ENABLE=1

# Install runtime dependencies and PHP extensions
RUN install-php-extensions intl && \
    apk add --no-cache nginx supervisor dos2unix nodejs yarn

WORKDIR /app

# Copy application files from builder stage
COPY --from=builder /src/backend /app/backend
COPY --from=builder /src/frontend /app/frontend
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisord.conf
COPY startup.sh /startup.sh

# Set up directories and permissions
RUN mkdir -p /app/backend/bootstrap/cache \
    && mkdir -p /app/backend/storage \
    && chown -R www-data:www-data /app/backend \
    && find /app/backend -type d -exec chmod 755 {} \; \
    && find /app/backend -type f -exec chmod 644 {} \; \
    && chmod -R 755 /app/backend/storage /app/backend/bootstrap/cache \
    && chmod -R 755 /app/backend/vendor/ezyang/htmlpurifier/library/HTMLPurifier/DefinitionCache/Serializer

# Make startup script executable
RUN dos2unix /startup.sh && chmod +x /startup.sh

USER www-data

EXPOSE 5678

WORKDIR /app

CMD ["/startup.sh"]
