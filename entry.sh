#!/bin/sh
export LOCAL_IP=$(curl -s 169.254.169.254/latest/meta-data/local-ipv4)
echo $LOCAL_IP
echi $@
exec "/bin/registrator"
