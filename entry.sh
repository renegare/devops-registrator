#!/bin/sh

if ! [[ -z ${GET_CONSUL_HOST+x} ]];
  then
    HOST=$(curl -s $GET_CONSUL_HOST);
    XARGS="-ip $HOST consul://$HOST:8500";
fi

`/bin/registrator $@ $XARGS`
