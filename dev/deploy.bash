#!/bin/bash -e

log=/tmp/carnivora-dev-deploy.log
setup=../examples/setup.yml
db=postgresql://postgres@/carnivora

echo "" > $log
chmod go= $log

hamsql install \
 --delete-existing-database \
 --delete-residual-roles \
 --permit-data-deletion \
 --sql-log $log \
 --setup $setup \
 --connection $db

psql $db --file $1 --set ON_ERROR_STOP=on

