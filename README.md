### Apache PHP Docker Image

- Inherit from this image `telosma/php56-apache2:1.0` (https://hub.docker.com/r/telosma/php56-apache2)

- Add more services: `cron`, `postfix`, `rsyslog`

- Version:
    + OS: Debian 9
    + Apache: v2.4.5
    + PHP: v5.6.38
    + Postfix: v3.1.12

- Enviroment Variables:
    + `PHP_TZ` : Set timezone of `PHP` (https://www.php.net/manual/en/timezones.php)
        ```
        # Example
        # PHP_TZ = Asia/Tokyo
        ```
    + `MAIL_RELAY_HOST`: Set `relayhost` of `Postfix`
    
        ```
        MAIL_RELAY_HOST = [hostname]:port
        
        # Example
        # MAIL_RELAY_HOST = [smtp.example.com]:25
        ```