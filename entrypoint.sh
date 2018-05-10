#!/bin/bash
set -e

if [ ! -f '/var/www/localhost/htdocs/index.php' ] && [ -z "$WP_SKIP_DOWNLOAD" ]; then
    echo "=== downloading latest wordpress tarball ==="
    curl -sL --progress-bar https://wordpress.org/latest.tar.gz | tar -xvz -C /var/www/localhost/htdocs --strip-components=1
fi

if [ ! -f '/var/www/localhost/htdocs/.htaccess' ]; then
cat > '/var/www/localhost/htdocs/.htaccess' << EOF
# BEGIN WordPress
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
</IfModule>
# END WordPress
EOF
fi

chown -R apache:apache /var/www/localhost/htdocs

exec "$@"