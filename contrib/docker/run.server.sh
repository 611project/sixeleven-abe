#!/bin/sh

# initial setup of sqlite
python -m Abe.abe --config sqlite.conf --commit-bytes 100000 --no-serve

# rescan after initial setup and
# update afterwards the database once a minute in the background
python -m Abe.abe --config sqlite.conf --no-serve --rescan && \
while true
do
  python -m Abe.abe --config sqlite.conf --no-serve --upgrade
  sleep 60
done &

# serve it up
python -m Abe.abe --config sqlite.conf
