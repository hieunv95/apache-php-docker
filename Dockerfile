FROM telosma/php56-apache2:1.0

MAINTAINER "Hieu Nguyen <hieu2395@gmail.com>"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    rsyslog supervisor cron libsasl2-modules postfix

# Configure and start Postfix service.
RUN cp /etc/postfix/main.cf /etc/postfix/main.cf.bak

ARG MAIL_RELAY_HOST
# Set relayhost
RUN if [ ${MAIL_RELAY_HOST} ]; then \
    sed -i '/^relayhost = /s/^/#/g' /etc/postfix/main.cf \
    && echo "relayhost = ${MAIL_RELAY_HOST}" >> /etc/postfix/main.cf \
;fi

# Set PHP timezone.
ARG PHP_TZ
RUN if [ ${PHP_TZ} ]; then \
    echo "date.timezone =${PHP_TZ}" >> /usr/local/etc/php/php.ini \
;fi

RUN echo 'sendmail_path = "/usr/sbin/sendmail -t -i"' >> /usr/local/etc/php/php.ini

# Add suporvisor config
ADD config/postfix.sh /postfix.sh
RUN chmod +x /postfix.sh
ADD config/supervisor.conf /etc/supervisor/conf.d/default.conf

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
