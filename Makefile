VERSION=$(shell git rev-parse --short HEAD)
DOCKER_REPO=renegare
APP_NAME=devops-registrator


build:
	echo $(VERSION) > VERSION
	docker build -t $(DOCKER_REPO)/$(APP_NAME):latest .
	docker tag $(DOCKER_REPO)/$(APP_NAME):latest $(DOCKER_REPO)/$(APP_NAME):$(VERSION)
	-docker ps -qaf status=exited | xargs docker rm
	-docker images -qaf dangling=true | xargs docker rmi
	docker images | grep $(DOCKER_REPO)/$(APP_NAME)

push:
	docker push $(DOCKER_REPO)/$(APP_NAME):latest
	docker push $(DOCKER_REPO)/$(APP_NAME):$(VERSION)
