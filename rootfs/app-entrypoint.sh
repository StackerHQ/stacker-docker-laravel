#!/bin/bash

set -e

service nginx start
service php7.1-fpm start

exec "$@"
