#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
    rm tmp/pids/server.pid
fi

bin/rails db:create && \
  bin/rails db:migrate && \
  bin/rails db:seed_if_necessary

bundle exec rails server --port 3000 --binding 0.0.0.0
