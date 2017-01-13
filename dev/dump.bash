#!/bin/bash

pg_dump --user postgres --data-only --column-inserts carnivora \
    | grep . \
    | grep -v 'SET s' \
    | grep -v -- '--'
