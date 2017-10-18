#! /bin/bash
readonly PARAM_FILE="/var/www/html/ws/app/config/parameters.yml"
secret=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)

sed -i "s#<<dbhost>>#${DBHOST}#" "${PARAM_FILE}"
sed -i "s#<<dbuser>>#${DBUSER}#" "${PARAM_FILE}"
sed -i "s#<<dbpassword>>#${DBPASSWD}#" "${PARAM_FILE}"
sed -i "s#<<secret>>#${secret}#" "${PARAM_FILE}"
apachectl -DFOREGROUND
while :
do
    sleep 1
done
