#!/bin/sh

CONSUL_HOST=""

if [ -z ${GET_CONSUL_HOST+x} ];
  then `/bin/registrator $@`;
else `CONSUL_HOST=$(curl -s $GET_CONSUL_HOST) /bin/registrator $@ -ip $CONSUL_HOST consul://$CONSUL_HOST:8500` ;
fi
