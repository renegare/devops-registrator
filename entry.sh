#!/bin/sh

CONSUL_HOST=""

if [ -z ${GET_CONSUL_HOST+x} ];
  then exec  "";
else CONSUL_HOST=consul://$(curl -s $GET_CONSUL_HOST):8500;
fi

`/bin/registrator $@ $CONSUL_HOST`
