#!/bin/sh
set -e

echo "Caching configuration..."
(php /var/www/php/artisan config:cache && php /var/www/php/artisan route:cache && php /var/www/php/artisan view:cache)
exec php-fpm
