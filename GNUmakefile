HOME									:= $(HOME)
export HOME
PWD										?= $(notdir $(PWD))
#PWD									?= statoshi.host
export PWD

THIS_FILE								:= $(lastword $(MAKEFILE_LIST))
export THIS_FILE
TIME									:= $(shell date +%s)
export TIME

ifeq ($(user),)
## USER retrieved from env, UID from shell.
HOST_USER								?=  $(strip $(if $(USER),$(USER),nodummy))
HOST_UID								?=  $(strip $(if $(shell id -u),$(shell id -u),4000))
else
# allow override by adding user= and/ or uid=  (lowercase!).
# uid= defaults to 0 if user= set (i.e. root).
HOST_USER								:= $(user)
HOST_UID								:= $(strip $(if $(uid),$(uid),0))
endif
export HOST_USER
export HOST_UID

# Note the different service configs in docker-compose.yml.
# We override this default for different build/run configs
ifeq ($(target),)
SERVICE_TARGET							?= shell
else
SERVICE_TARGET							:= $(target)
endif
export SERVICE_TARGET

ifeq ($(alpine),)
ALPINE_VERSION							:= 3.11.6
else
ALPINE_VERSION							:= $(alpine)
endif
export ALPINE_VERSION

# PROJECT_NAME defaults to name of the current directory.
PROJECT_NAME							:= $(notdir $(PWD))
export PROJECT_NAME

#GIT CONFIG
GIT_USER_NAME							:= $(shell git config user.name)
export GIT_USER_NAME
GIT_USER_EMAIL							:= $(shell git config user.email)
export GIT_USER_EMAIL
GIT_SERVER								:= https://github.com
export GIT_SERVER
GIT_PROFILE								:= bitcoincore-dev
export GIT_PROFILE
GIT_BRANCH								:= $(shell git rev-parse --abbrev-ref HEAD)
export GIT_BRANCH
GIT_HASH								:= $(shell git rev-parse HEAD)
export GIT_HASH
GIT_REPO_ORIGIN							:= $(shell git remote get-url origin)
export GIT_REPO_ORIGIN
GIT_REPO_NAME							:= $(PROJECT_NAME)
export GIT_REPO_NAME
GIT_REPO_PATH							:= ~/$(GIT_REPO_NAME)
export GIT_REPO_PATH
ifeq ($(no-cache),true)
NO_CACHE								:= --no-cache
else
NO_CACHE								:=	
endif
export NO_CACHE

ifeq ($(verbose),true)
VERBOSE									:= --verbose
else
VERBOSE									:=	
endif
export VERBOSE

ifeq ($(port),)
PUBLIC_PORT								:= 80
else
PUBLIC_PORT								:= $(port)
endif
export PUBLIC_PORT
ifneq ($(passwd),)
PASSWORD								:= $(passwd)
else 
PASSWORD								:= changeme
endif
export PASSWORD

ifeq ($(cmd),)
CMD_ARGUMENTS							:= 	
else
CMD_ARGUMENTS							:= $(cmd)
endif
export CMD_ARGUMENTS
DOCKER=docker
export DOCKER
ifeq ($(SITE),)
    SITE   := .
    export SITE
    TAG        := org-builder
    export     TAG
else
    SITE       := $(SITE)
    export     SITE
    TAG        := $(shell echo $(notdir $(SITE)) | awk '{print tolower($$0)}')
    export     TAG
endif

.PHONY: report
report:
	@echo ''
	@echo '	[ARGUMENTS]	'
	@echo '      args:'
	@echo '        - PWD=${PWD}'
	@echo '        - HOME=${HOME}'
	@echo '        - BITCOIN_DATA_DIR=${BITCOIN_DATA_DIR}'
	@echo '        - STATOSHI_DATA_DIR=${STATOSHI_DATA_DIR}'
	@echo '        - UMBREL=${UMBREL}'
	@echo '        - THIS_FILE=${THIS_FILE}'
	@echo '        - TIME=${TIME}'
	@echo '        - HOST_USER=${HOST_USER}'
	@echo '        - HOST_UID=${HOST_UID}'
	@echo '        - SERVICE_TARGET=${SERVICE_TARGET}'
	@echo '        - ALPINE_VERSION=${ALPINE_VERSION}'
	@echo '        - PUBLIC_PORT=${PUBLIC_PORT}'
	@echo '        - PROJECT_NAME=${PROJECT_NAME}'
	@echo '        - GIT_USER_NAME=${GIT_USER_NAME}'
	@echo '        - GIT_USER_EMAIL=${GIT_USER_EMAIL}'
	@echo '        - GIT_SERVER=${GIT_SERVER}'
	@echo '        - GIT_PROFILE=${GIT_PROFILE}'
	@echo '        - GIT_BRANCH=${GIT_BRANCH}'
	@echo '        - GIT_HASH=${GIT_HASH}'
	@echo '        - GIT_REPO_ORIGIN=${GIT_REPO_ORIGIN}'
	@echo '        - GIT_REPO_NAME=${GIT_REPO_NAME}'
	@echo '        - GIT_REPO_PATH=${GIT_REPO_PATH}'

.PHONY: image image_alpine shell server clean
# Build the docker image or create your own Dockerfile
image:image_alpine
	${DOCKER} build -t ${TAG} .
image_alpine:
	${DOCKER} build -t ${TAG} . -f Dockerfile.alpine
# make image or server first
# use SITE= to point to the container
# Example
# SITE=~/Bitcoin.org make image
# OR
# SITE=~/Bitcoin.org make server
# SITE=~/Bitcoin.org make shell
shell:
	${DOCKER} run --rm -it \
		-p ${PUBLIC_PORT}:4000 \
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
		-p ${PUBLIC_PORT}:4000 \
		-u `id -u`:`id -g` \
		-v ${PWD}/docs:/src/gh/pages-gem \
		-v `realpath ${SITE}`:/src/site \
		-w /src/site \
		${TAG}
	|| echo 'Image(s) for "$(TAG)" does not exist.'
#######################
clean:
	@echo 'clean'
	bash -c 'docker rmi -f $(TAG)'
	@docker rmi -f $(TAG) \
	&& echo 'Image(1) for "$(TAG)" removed.' \
	&& echo 'Image(2) for "$(TAG)" removed.' \
	|| echo 'Image(3) for "$(TAG)" already removed.'
#######################
-include Makefile

