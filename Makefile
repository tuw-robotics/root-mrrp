# Check if the environment variables are set
$(if $(PROJECT_NAME),,$(error The environment variable PROJECT_NAME is not set!))

PROJECT_DIR = $(shell pwd)
SHELL = /usr/bin/env bash
BUILD_TYPE = Debug

all: help

help:
	@echo ""
	@echo "   Help Menu"
	@echo ""
	@echo "   make build             - builds workspace"
	@echo "   make clean             - removes install, build, log"
	@echo "   make clone             - clones the subrepostories needed"
	@echo "   make base              - builds the base image used by the devcontainer"
	@echo "   make attach            - attaches the bash to the running project container"
	@echo ""

attach:
	@docker exec -it -e TERM=xterm-256color -w $(PROJECT_DIR) $(PROJECT_NAME) bash

base:
	cd ./.devcontainer; make base

clean-ws00:
	rm -rf ./ws00/install ./ws00/build  ./ws00/log

clean-ws01:
	rm -rf ./ws01/install ./ws01/build  ./ws01/log

clean-ws02:
	rm -rf ./ws02/install ./ws02/build  ./ws02/log

clean-all: clean-ws00 clean-ws01 clean-ws02
	rm -rf ./install ./build  ./log

delete-packages:	
	rm -rf ./ws00/src/*
	rm -rf ./ws01/src/*
	rm -rf ./ws02/src/*

build-ws00: 
	cd $(PROJECT_DIR)/ws00; \
	source /opt/ros/$(ROS_DISTRO)/setup.bash; \
	colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) -DCMAKE_EXPORT_COMPILE_COMMANDS=ON; \

build-ws01: 
	cd $(PROJECT_DIR)/ws01; \
	source /opt/ros/$(ROS_DISTRO)/setup.bash; \
	source ${PROJECT_DIR}/ws00/install/setup.bash; \
	colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) -DCMAKE_EXPORT_COMPILE_COMMANDS=ON; \

build-ws02: 
	cd $(PROJECT_DIR)/ws02; \
	source /opt/ros/$(ROS_DISTRO)/setup.bash; \
	source ${PROJECT_DIR}/ws00/install/setup.bash; \
	source ${PROJECT_DIR}/ws01/install/setup.bash; \
	colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) -DCMAKE_EXPORT_COMPILE_COMMANDS=ON; \

build:  \
	build-ws00 \
	build-ws01 \
	build-ws02 \

pull:
	git pull origin
	find . -type d -name .git -exec echo {} \; -exec git --git-dir={} --work-tree=$(PROJECT_DIR)/{}/.. pull origin \;
	
status:
	git status -s
	find . -type d -name .git -exec echo {} \; -exec git --git-dir={} --work-tree=$(PROJECT_DIR)/{}/.. status -s \;

include *.mk