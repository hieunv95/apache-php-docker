#!/bin/bash

cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf
/usr/sbin/postfix -c /etc/postfix start
