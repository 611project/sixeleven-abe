#!/bin/sh

# initial setup of sqlite
python -m Abe.abe --config sqlite.conf --no-serve

# update the database once a minute in the background
while true
do
  python -m Abe.abe --config sqlite.conf --no-serve --upgrade
  sleep 60
done &

# serve it up
python -m Abe.abe --config sqlite.conf
