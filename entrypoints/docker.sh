#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
    rm tmp/pids/server.pid
fi

DIR=$(pwd)
FILE="$DIR"/config/development_env.rb
if [ ! -f "$FILE" ]; then
    echo "# This file contains the ENV vars necessary to run the app locally." >> $FILE
    echo "# Some of these values are sensitive, and some are developer specific." >> $FILE
    echo "#" >> $FILE
    echo "# DO NOT CHECK THIS FILE INTO VERSION CONTROL!" >> $FILE
fi

bin/rails db:create && \
  bin/rails db:migrate && \
  bin/rails db:seed_if_necessary

bundle exec rails server --port 3000 --binding 0.0.0.0
