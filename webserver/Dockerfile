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
RUN composer create-project symfony/framework-standard-edition ws "3.4.*" && chown -R www-data:www-data ws
WORKDIR /var/www/html/ws
RUN mkdir web/js && mkdir web/css && \
rm -fr app/config app/AppKernel.php app/Resources ws/src/AppBundle
COPY --chown=www-data:www-data adapt_param_from_env.bash /tmp/adapt_param_from_env.bash
COPY --chown=www-data:www-data composer.json composer.json
ADD --chown=www-data:www-data https://code.jquery.com/jquery-3.3.1.js web/js/jquery.js
ADD --chown=www-data:www-data https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js web/js/popper.js
ADD --chown=www-data:www-data https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.css web/css/datatables.css
ADD --chown=www-data:www-data https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.js web/js/datatables.js
ADD --chown=www-data:www-data https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js web/js/bootstrap.js
ADD --chown=www-data:www-data https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css web/css/bootstrap.css
COPY --chown=www-data:www-data app/AppKernel.php app/AppKernel.php
COPY --chown=www-data:www-data app/config app/config
COPY --chown=www-data:www-data app/Resources app/Resources
COPY --chown=www-data:www-data web/* web/
COPY --chown=www-data:www-data src/FantasyFootball src/FantasyFootball
COPY --chown=www-data:www-data tests/FantasyFootball tests/FantasyFootball
RUN composer dump-autoload
EXPOSE 80
CMD ["/bin/bash","/tmp/adapt_param_from_env.bash"]

