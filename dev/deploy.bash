#!/bin/bash -e

log=/tmp/carnivora-dev-deploy_`date +%F_%T`.log
yamsql=/tmp/yamsql-out
setup=../examples/setup.yml
db=postgresql://postgres@/carnivora

echo "" > $log
chmod go= $log

if [ ! "$2" ] || [ "$2" == "1" ]; then
hamsql install \
 --delete-existing-database \
 --delete-residual-roles \
 --permit-data-deletion \
 --sql-log $log \
 --setup $setup \
 --connection $db
fi

if [ ! "$2" ] || [ "$2" == "2" ]; then
echo "LISTEN \"carnivora/server.example\"; SELECT pg_sleep(2); SELECT 1;" | psql carnivora postgres &

psql $db --file $1 --set ON_ERROR_STOP=on
echo "CREATE EXTENSION plpgsql_check;" | psql $db

sleep 2
echo "---"
fi

#hamsql yamsql --connection $db "${yamsql}"
