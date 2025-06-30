#!/bin/sh
set -e

echo "--- Preparing runtime directories ---"
mkdir -p /var/lib/nginx/logs
mkdir -p /var/lib/nginx/tmp


cd /app/backend

if ! php artisan migrate --force; then
    echo "============================================"
    echo "ERROR: Migrations could not complete. Check the error above."
    echo "Ensure DATABASE_URL is set."
    echo "============================================"
fi

php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

# echo "Caching Laravel configuration for production..."
# php artisan config:cache
# php artisan route:cache

exec /usr/bin/supervisord -c /etc/supervisord.conf
