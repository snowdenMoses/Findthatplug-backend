#!/bin/sh

set -e
# Remove the if block (and fi) if migration does not work
# if [ "${*}" == "./bin/rails server" ]; then
  rake db:create
  rake db:migrate
# fi

exec "$@"

# if [ "${*}" == "./bin/rails server" ]; then
#   bin/rails db:create
#   bin/rails db:prepare
# fi

# exec "${@}"