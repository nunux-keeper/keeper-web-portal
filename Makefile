.SILENT :
.PHONY : up down install deploy deploy-github

USERNAME:=nunux-keeper
APPNAME:=keeper-web-portal

# Define port
PORT?=3000
PORTS_FLAGS=-p $(PORT):1313

# Custom run flags
RUN_CUSTOM_FLAGS?=$(PORTS_FLAGS)

# Custom shell flags
SHELL_CUSTOM_FLAGS=-P

# Docker configuartion regarding the system architecture
BASEIMAGE=node:6-onbuild
ARM_BASEIMAGE=hypriot/rpi-node/6-onbuild

DEPLOY_DIR:=/var/www/html/keeper.nunux.org

# Include common Make tasks
ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
DOCKERFILES:=$(ROOT_DIR)/dockerfiles
include $(DOCKERFILES)/common/_Makefile

## Install builded static files (needs root privileges)
install: build
	echo "Install generated files at deployment location..."
	mkdir -p $(DEPLOY_DIR)
	$(DOCKER) run --rm -v $(DEPLOY_DIR):$(VOLUME_CONTAINER_PATH)/public $(IMAGE) hugo

## Deploy application
deploy:
	echo "Deploying application..."
	git push deploy dev:master

## Deploy application to GitHub
deploy-github:
	echo "Deploying application to GitHub..."
	npm run deploy
