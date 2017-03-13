#!/bin/bash -e

INIT_SEM=/tmp/initialized.sem
PACKAGE_FILE=/app/composer.json

log() {
  echo -e "\033[0;33m$(date "+%H:%M:%S")\033[0;37m ==> $1."
}

fresh_container() {
  [ ! -f $INIT_SEM ]
}

app_present() {
  [ -f /app/config/database.php ]
}

dependencies_up_to_date() {
  [ ! $PACKAGE_FILE -nt $INIT_SEM ]
}

setup_db() {
  log "Configuring the database"
  php artisan migrate
}

if [ "${1}" == "/start.sh" ]; then
  if ! app_present; then
    log "Creating laravel application"
    cp -r /tmp/app/ /
  fi

  if ! dependencies_up_to_date; then
    log "Installing/Updating Laravel dependencies (composer)"
    composer update
    log "Dependencies updated"
  fi

  if fresh_container; then
    setup_db
    log "Initialization finished"
    touch $INIT_SEM
  fi
fi

exec "$@"