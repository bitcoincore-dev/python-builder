DOCKER=docker
export DOCKER
TAG=org-builder
export TAG

ifeq ($(SITE),)
    SITE   := .
    export SITE
else
    SITE   ?= $(SITE)
    export SITE
endif



.PHONY:
	image image_alpine server shell

# Build the docker image
image:
	${DOCKER} build -t ${TAG} .
image_alpine:
	${DOCKER} build -t ${TAG} . -f Dockerfile.alpine

# Produce a bash shell
shell:
	${DOCKER} run --rm -it \
		-p 4000:4000 \
		-u `id -u`:`id -g` \
		-v ${PWD}/docs:/src/gh/pages-gem \
		-v `realpath ${SITE}`:/src/site \
		-w /src/site \
		${TAG} \
		/bin/bash

# Spawn a server. Specify the path to the SITE directory by
# exposing it using `expose SITE="../path-to-jekyll-site"` prior to calling or
# by prepending it to the make rule e.g.: `SITE=../path-to-site make server`
server: image
	test -d "${SITE}" || \
		(echo -E "specify SITE e.g.: SITE=/path/to/site make server"; exit 1) && \
	${DOCKER} run --rm -it \
		-p 4000:4000 \
		-u `id -u`:`id -g` \
		-v ${PWD}/docs:/src/gh/pages-gem \
		-v `realpath ${SITE}`:/src/site \
		-w /src/site \
		${TAG}
	|| echo 'Image(s) for "gh-pages" already removed.'
#######################
clean:
	@echo 'clean'
	@docker-compose -p gh-pages down --remove-orphans --rmi all 2>/dev/null \
	&& echo 'Image(s) for "gh-pages" removed.' \
	|| echo 'Image(s) for "gh-pages" already removed.'
#######################
prune:
	docker system prune -af
#######################
