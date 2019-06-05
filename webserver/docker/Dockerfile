FROM debian

RUN apt-get update && \
apt-get install -y apache2 php7.0 php7.0-mysql apache2-mod-php7.0 php7.0-xml php7.0-zip php7.0-mbstring unzip ca-certificates && \
echo "date.timezone=Europe/Paris" >> /etc/php/7.0/cli/php.ini && \
echo "date.timezone=Europe/Paris" >> /etc/php/7.0/apache2/php.ini && \
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
ADD https://github.com/trambi/FantasyFootball/archive/v1.18-rc.2.tar.gz v1.18-rc.2.tar.gz
RUN tar xzf v1.18-rc.2.tar.gz && \
rm -fr ws/src/FantasyFootball && \
mv FantasyFootball-1.18-rc.2 ws/src/FantasyFootball && \
rm -fr ws/src/AppBundle && \
rm -f v1.18-rc.2.tar.gz

COPY app_config_config.yml ws/app/config/config.yml
COPY routing.yml ws/app/config/routing.yml
COPY parameters.yml ws/app/config/parameters.yml
COPY base.html.twig ws/app/Resources/views/base.html.twig
COPY adapt_param_from_env.bash /root/adapt_param_from_env.bash
COPY AppKernel.php ws/app/AppKernel.php
COPY services.yml ws/app/config/services.yml
ADD https://github.com/twbs/bootstrap/releases/download/v4.3.1/bootstrap-4.3.1-dist.zip bootstrap-4.3.1-dist.zip
RUN unzip bootstrap-4.3.1-dist.zip && \
mkdir ws/web/js && mkdir ws/web/css && \
cp bootstrap-4.3.1-dist/js/bootstrap.js ws/web/js/ && \
cp bootstrap-4.3.1-dist/css/bootstrap.css ws/web/css/ && \
rm -fr bootstrap-4.3.1-dist && \
chown -R www-data:www-data ws

WORKDIR /var/www/html/ws/src/FantasyFootball
RUN /bin/bash deploy_on_ws.bash start

WORKDIR /var/www/html/ws

RUN composer dump-autoload
EXPOSE 80
CMD ["/bin/bash","/root/adapt_param_from_env.bash"]
