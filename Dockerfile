FROM alpine:3.9
LABEL maintainer="Sean Cheung <theoxuanx@gmail.com>"

ARG CN_MIRROR=false
RUN if [ "$CN_MIRROR" = true ]; then sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories; fi

RUN set -ex \
    && echo "Install Dependencies..." \
    && apk add --update --no-cache php7 php7-apache2 php7-mcrypt php7-mysqli \
        php7-curl php7-gd php7-mbstring php7-xml php7-xmlrpc php7-zlib php7-dom \
        php7-posix php7-iconv php7-ftp php7-gettext php7-exif \
        php7-json php7-sockets php7-tokenizer php7-fileinfo php7-session \
        bash curl ca-certificates openssl supervisor apache2 \
	&& echo "Initializing directories..." \
    && mkdir -p /run/apache2 \
    && chown apache:apache /run/apache2 \
    && sed -ri "s/^(\s*DirectoryIndex\s*).+$/\1index.php index.html/g" /etc/apache2/httpd.conf \
    && sed -i "/^#ServerName/c ServerName localhost" /etc/apache2/httpd.conf \
    && sed -i "s/Indexes\s*//g" /etc/apache2/httpd.conf \
    && sed -ri "s/^#(.+mod_rewrite.so)/\1/g" /etc/apache2/httpd.conf \
    && sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/httpd.conf \
    && echo "Clean Up..." \
    && rm /var/www/localhost/htdocs/*

COPY supervisord.conf /etc/
COPY entrypoint.sh /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]