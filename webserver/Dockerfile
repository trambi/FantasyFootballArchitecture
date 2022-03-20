FROM debian:10
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
RUN composer create-project symfony/framework-standard-edition ws "3.4.*" && chown -R www-data:www-data ws && rm -fr ws/src/AppBundle
RUN mkdir ws/web/js && mkdir ws/web/css
COPY --chown=www-data:www-data adapt_param_from_env.bash /tmp/adapt_param_from_env.bash
COPY --chown=www-data:www-data src/TournamentAdminBundle ws/src/FantasyFootball/TournamentAdminBundle
COPY --chown=www-data:www-data src/TournamentCoreBundle ws/src/FantasyFootball/TournamentCoreBundle
COPY --chown=www-data:www-data src/UserBundle ws/src/FantasyFootball/UserBundle
COPY --chown=www-data:www-data composer.json ws/
ADD --chown=www-data:www-data https://code.jquery.com/jquery-3.3.1.js ws/web/js/jquery.js
ADD --chown=www-data:www-data https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js ws/web/js/popper.js
ADD --chown=www-data:www-data https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.css ws/web/css/datatables.css
ADD --chown=www-data:www-data https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.js ws/web/js/datatables.js
ADD --chown=www-data:www-data https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js ws/web/js/bootstrap.js
ADD --chown=www-data:www-data https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css ws/web/css/bootstrap.css
COPY --chown=www-data:www-data config/* ws/app/config/
COPY --chown=www-data:www-data Resources/views/* ws/app/Resources/views/
COPY --chown=www-data:www-data app/* ws/app/
COPY --chown=www-data:www-data web/* ws/web/
WORKDIR /var/www/html/ws
RUN composer dump-autoload
EXPOSE 80
CMD ["/bin/bash","/tmp/adapt_param_from_env.bash"]

