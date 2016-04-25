#!/bin/sh

CONSUL_HOST=""

if [ -z ${GET_CONSUL_HOST+x} ];
  then printf "";
  else CONSUL_HOST=$(curl -s $GET_CONSUL_HOST);
fi

`/bin/registrator $@ $CONSUL_HOST`
