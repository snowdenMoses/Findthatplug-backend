#!/bin/sh

if [ "${*}" == "./bin/rails server" ]; then
  bin/rails db:create
  bin/rails db:prepare
fi

exec "${@}"