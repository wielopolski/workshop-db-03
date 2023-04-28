#!/bin/bash
set -e

COMMAND="${1:-server}"

if [[ $COMMAND == "server" ]]; then
  echo "Starting server..."
  bundle exec rackup -p 3000 config.ru

elif [[ $COMMAND == "migrate" ]]; then
  echo "Running migrate..."
  bundle exec rake db:migrate

elif [[ $COMMAND == "seeds" ]]; then
  echo "Running seeds..."
  bundle exec rake db:seed

else
  echo "Usage: entrypoint.sh [CMD]"
  exit 1
fi
