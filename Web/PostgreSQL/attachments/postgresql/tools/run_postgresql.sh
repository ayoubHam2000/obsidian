#!/bin/bash

echo "Start Script...."
PATH="$PATH:/usr/lib/postgresql/15/bin"

if [ $(ls /var/lib/postgresql/15/main/ | wc -l) == "0" ]; then
    echo "Init Data Base"
    initdb -D /var/lib/postgresql/15/main/
    echo "Change Pass"

fi

service postgresql start
psql -c "ALTER USER postgres PASSWORD '$POSTGRESQL_PASS';"
service postgresql stop

postgres -D /etc/postgresql/15/main
#tail -f