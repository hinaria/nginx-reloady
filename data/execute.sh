#!/bin/bash

nginx "$@"

inotifywait -e modify -e move -e create -e delete --monitor --recursive --format "%T" --timefmt "%Y-%m-%d %H:%M:%S" /etc/nginx/conf.d/ | while read date time; do
    nginx -t

    if [ $? -eq 0 ]; then
        echo "${date} ${time}: changes detected, reloading nginx."

        nginx -s reload
    else
        echo "${date} ${time}: changes detected, but configuration was invalid. skipping."
    fi
done
