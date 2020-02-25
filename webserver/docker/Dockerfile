FROM debian:10

RUN apt-get update && \
apt-get install -y apache2 php php-mysql libapache2-mod-php php-xml php-zip php-mbstring unzip ca-certificates && \
echo "date.timezone=Europe/Paris" >> /etc/php/7.3/cli/php.ini && \
echo "date.timezone=Europe/Paris" >> /etc/php/7.3/apache2/php.ini && \
mkdir -p /usr/local/bin
ADD https://symfony.com/installer /usr/local/bin/symfony
ADD https://getcomposer.org/installer composer-setup.php

RUN chmod a+x /usr/local/bin/symfony && \
php composer-setup.php && \
php -r "unlink('composer-setup.php');"&& \
mv composer.phar /usr/local/bin/composer

COPY ws.conf /etc/apache2/sites-available/001-ws.conf
RUN a2ensite 001-ws.conf && a2dissite 000-default.conf

WORKDIR /var/www/html

RUN symfony new ws 3.4
ARG version=1.18
ADD https://github.com/trambi/FantasyFootball/archive/v${version}.tar.gz ${version}.tar.gz
RUN tar xzf ${version}.tar.gz && \
rm -fr ws/src/FantasyFootball && \
mv FantasyFootball-${version} ws/src/FantasyFootball && \
rm -fr ws/src/AppBundle && \
rm -f ${version}.tar.gz

RUN mkdir ws/web/js && mkdir ws/web/css
ADD https://code.jquery.com/jquery-3.3.1.js ws/web/js/jquery.js
ADD https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js ws/web/js/popper.js
ADD https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.css ws/web/css/datatables.css
ADD https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.js ws/web/js/datatables.js
ADD https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js ws/web/js/bootstrap.js
ADD https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css ws/web/css/bootstrap.css
COPY app_config_config.yml ws/app/config/config.yml
COPY routing.yml ws/app/config/routing.yml
COPY parameters.yml ws/app/config/parameters.yml
COPY base.html.twig ws/app/Resources/views/base.html.twig
COPY adapt_param_from_env.bash /root/adapt_param_from_env.bash
COPY AppKernel.php ws/app/AppKernel.php
COPY services.yml ws/app/config/services.yml
RUN chown -R www-data:www-data ws

WORKDIR /var/www/html/ws/src/FantasyFootball
RUN /bin/bash deploy_on_ws.bash start

WORKDIR /var/www/html/ws

RUN composer dump-autoload
EXPOSE 80
CMD ["/bin/bash","/root/adapt_param_from_env.bash"]
