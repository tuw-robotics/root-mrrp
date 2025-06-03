# Check if the environment variables are set
$(if $(PROJECT_NAME),,$(error The environment variable PROJECT_NAME is not set!))
$(if $(DOCKER_PREFIX),,$(error The environment variable DOCKER_PREFIX is not set!))
$(if $(DOCKER_OWNER),,$(error The environment variable DOCKER_OWNER is not set!))
$(if $(ROS_DISTRO),,$(error The environment variable ROS_DISTRO is not set!))


PROJECT_DIR = $(shell pwd)
SHELL = /usr/bin/env bash
DOCKER_IMAGE_BASE=$(DOCKER_PREFIX)-$(ROS_DISTRO)

all: help

help:
	@echo ""
	@echo "   Help Menu"
	@echo ""
	@echo "   make base       - builds the base image used by the devcontainer"
	@echo "   make attach     - attaches the bash to the devcontainer"
	@echo "   make containers - lists containers nicly formated"
	@echo "   make remove     - removes project related containers"
	@echo "   make rmi        - removes project related images"
	@echo "   make push       - pushes the base container to dockerhub"
	@echo ""
	@echo "   more"
	@echo ""
	@echo "   docker login -u ${DOCKER_OWNER}   - login to dockerhub"
	@echo "   docker login registry.auto.tuwien.ac.at -u USERNAME"
	@echo "   docker image prune      - deletes all unlinked images"
	@echo "   docker system prune -a  - removes unused containers, networks, images, and cache"
	@echo "   docker system df        - docker disk usage"
	@echo ""


attach:
	@docker exec -it -e TERM=xterm-256color -w $(PROJECT_DIR) $(PROJECT_NAME) bash

base:
	@docker build --rm -t ${DOCKER_OWNER}/${DOCKER_IMAGE_BASE}  -f Dockerfile-base  --build-arg ROS_DISTRO=${ROS_DISTRO}  --debug .

push:
	@docker push $(DOCKER_OWNER)/$(DOCKER_IMAGE_BASE)

containers:
	@docker ps -a  --format "table {{.Names}}\t{{.ID}}\t{{.Status}}"
	
remove:
	@docker stop $(PROJECT_NAME); docker rm $(PROJECT_NAME)

rmi:
	@docker image rm -f $$(docker images -a -q --filter "reference=*$(PROJECT_NAME)*")
	
prune:
	docker image prune
	