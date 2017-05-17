.SILENT :
.PHONY : up down install deploy

USERNAME:=nunux-keeper
APPNAME:=keeper-web-portal

# Define port
PORT?=1313
PORTS_FLAGS=-p $(PORT):1313

# Custom run flags
RUN_CUSTOM_FLAGS?=$(PORTS_FLAGS)
RUN_FLAGS=--rm -it $(RUN_CUSTOM_FLAGS)

# Custom shell flags
SHELL_CUSTOM_FLAGS=-P

# Docker configuartion regarding the system architecture
BASEIMAGE=alpine:latest

DEPLOY_DIR:=/var/www/html/keeper.nunux.org

# Include common Make tasks
ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
MAKEFILES:=$(ROOT_DIR)/makefiles
include $(MAKEFILES)/help.Makefile
include $(MAKEFILES)/docker.Makefile

## Install builded static files (needs root privileges)
install: build
	echo "Install generated files at deployment location..."
	mkdir -p $(DEPLOY_DIR)
	$(DOCKER) run --rm -v $(DEPLOY_DIR):$(VOLUME_CONTAINER_PATH)/public $(IMAGE) hugo

## Deploy application
deploy:
	echo "Deploying application..."
	git push deploy master

