#!/bin/bash
set -e

if [[ "$1" == "runserver" ]]; then
    exec gunicorn --workers 2 --bind 0.0.0.0:5000 wsgi:app --access-logfile /app/logs/uwsgi/osm_api.log
fi

exec "$@"
