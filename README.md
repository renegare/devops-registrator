# DevOps Registrator

This an enhancement of ```gliderlabs/registrator``` image to afford some variables
substitution of cli options passed to it.


## Usage

As normal; however if you need to dynamically specify the host ip at runtime of the
container, specify the location of this host ip using the ```GET_CONSUL_HOST``` environment var.

More info to come ...

See the docker-compose to see how it works.

**Disclaimer** NodeJS is used to manually test this thing actually works ;)
