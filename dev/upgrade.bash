#!/bin/bash

log=/tmp/carnivora-dev-upgrade.log
setup=../examples/setup.yml
db=postgresql://postgres@/carnivora

echo "" > $log
chmod go= $log

hamsql upgrade \
 --sql-log $log \
 --setup $setup \
 --connection $db

