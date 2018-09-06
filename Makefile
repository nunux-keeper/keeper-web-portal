.SILENT :

# Compose files
COMPOSE_FILES?=-f docker-compose.yml

# Deployment directory
DEPLOY_DIR:=/var/www/html/keeper.nunux.org

# Deployment base URL
DEPLOY_BASE_URL:=https://keeper.nunux.org/

# Include common Make tasks
root_dir:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
makefiles:=$(root_dir)/makefiles
include $(makefiles)/help.Makefile
include $(makefiles)/docker/compose.Makefile

all: help

# Get Docker binaries version
infos:
	echo "Using $(shell docker --version)"
	echo "Using $(shell docker-compose --version)"
.PHONY: infos

## Run the container in foreground
start:
	echo "Running container..."
	docker-compose $(COMPOSE_FILES) up --no-deps --no-build --abort-on-container-exit --exit-code-from portal portal
.PHONY: start

## Install as a service (needs root privileges)
install:
	echo "Install generated files at deployment location..."
	mkdir -p $(DEPLOY_DIR)
	docker run --rm \
		-v $(root_dir):/usr/share/blog \
		-v $(DEPLOY_DIR):/usr/share/nginx/html \
		-e "HUGO_BASEURL=$(DEPLOY_BASE_URL)" \
		monachus/hugo:v0.48 \
		hugo -d /usr/share/nginx/html/
.PHONY: install

