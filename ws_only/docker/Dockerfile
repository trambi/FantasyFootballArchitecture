FROM debian

RUN apt-get update && \
apt-get install -y apache2 php7.0 php7.0-mysql apache2-mod-php7.0 php7.0-xml php7.0-zip && \
apt-get install -y curl git && \
echo "date.timezone=Europe/Paris" >> /etc/php/7.0/cli/php.ini && \
echo "date.timezone=Europe/Paris" >> /etc/php/7.0/apache2/php.ini && \
mkdir -p /usr/local/bin && \
curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony && \
chmod a+x /usr/local/bin/symfony && \
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"&& \
php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
php composer-setup.php && \
php -r "unlink('composer-setup.php');"&& \
mv composer.phar /usr/local/bin/composer 

COPY ws.conf /etc/apache2/sites-available/001-ws.conf 
RUN a2ensite 001-ws.conf && a2dissite 000-default.conf

WORKDIR /var/www/html

RUN symfony new ws 2.8 && \
git clone --branch eurobowl_2017 https://github.com/trambi/FantasyFootball.git /var/www/html/ws/src/FantasyFootball && \
rm -fr /var/www/html/ws/src/AppBundle 
COPY routing.yml /var/www/html/ws/app/config/routing.yml
WORKDIR /var/www/html/ws/src/FantasyFootball
RUN /bin/bash deploy_on_ws.bash start

WORKDIR /var/www/html/ws

RUN apt-get remove -y git curl && \
sed -i "s#AppBundle\\\AppBundle#FantasyFootball\\\TournamentCoreBundle\\\FantasyFootballTournamentCoreBundle#" /var/www/html/ws/app/AppKernel.php && \
composer dump-autoload  
