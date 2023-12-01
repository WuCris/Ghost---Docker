#!/bin/sh

if [ "$NODE_ENV" = "production" ]; then
    sed -i 's/#include/include/g' /etc/nginx/conf.d/default.conf
fi