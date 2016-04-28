VERSION=$(shell git rev-parse --short HEAD)
DOCKER_REPO=renegare
APP_NAME=devops-registrator


build:
	echo $(VERSION) > VERSION
	docker-compose build app
	docker-compose build app
	docker-compose -p buildimage$(VERSION) build app
	docker tag buildimage$(VERSION)_app $(DOCKER_REPO)/$(APP_NAME):$(VERSION)
	docker tag buildimage$(VERSION)_app $(DOCKER_REPO)/$(APP_NAME):latest
	-docker ps -qaf status=exited | xargs docker rm
	-docker rmi buildimage$(VERSION)_app
	-docker images -qaf dangling=true | xargs docker rmi
	docker images | grep $(DOCKER_REPO)/$(APP_NAME)

push:
	docker push $(DOCKER_REPO)/$(APP_NAME):latest
	docker push $(DOCKER_REPO)/$(APP_NAME):$(VERSION)
