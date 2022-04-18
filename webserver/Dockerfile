FROM docker.io/library/debian:10
RUN apt-get update && \
apt-get install -y apache2 php php-mysql libapache2-mod-php php-xml php-zip php-mbstring unzip ca-certificates && \
echo "date.timezone=Europe/Paris" >> /etc/php/7.3/cli/php.ini && \
echo "date.timezone=Europe/Paris" >> /etc/php/7.3/apache2/php.ini
ADD https://getcomposer.org/installer composer-setup.php

RUN php composer-setup.php && \
php -r "unlink('composer-setup.php');"&& \
mv composer.phar /usr/local/bin/composer

COPY ws.conf /etc/apache2/sites-available/001-ws.conf
RUN a2ensite 001-ws.conf && a2dissite 000-default.conf && chown -R www-data:www-data /var/log/apache2

WORKDIR /var/www/html
COPY --chown=www-data:www-data files_to_serve ws
COPY --chown=www-data:www-data adapt_param_from_env.bash /tmp/adapt_param_from_env.bash
WORKDIR /var/www/html/ws
RUN composer install
RUN composer dump-autoload
RUN chown -R www-data:www-data ./
EXPOSE 80
CMD ["/bin/bash","/tmp/adapt_param_from_env.bash"]

