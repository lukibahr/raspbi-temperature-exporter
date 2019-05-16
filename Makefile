# Makefile

REGISTRY = docker.marksys.de
NAMESPACE = infrastructure
PROJECT = rapid7-exporter

RUNDOCKER = $(shell which docker) $(@)
RUNCOMPOSE = $(shell which docker-compose)

RUNLINT = $(shell which pylint)

VERSION = $(shell git rev-parse --short HEAD) 
BRANCH = $(shell git rev-parse --abbrev-ref HEAD)

CONTAINER = $(PROJECT):$(VERSION)

all: login build tag push
 
login: 
	@$(RUNDOCKER) --username=$(DOCKER_USER) --password=$(DOCKER_PASSWORD) $(REGISTRY)
	@$(RUNDOCKER) --username=$(DOCKER_USER) --password=$(DOCKER_PASSWORD) $(REGISTRY):9000

build: login
	$(RUNDOCKER) -t $(REGISTRY)/$(NAMESPACE)/$(CONTAINER) -f Dockerfile .

lint: 
	$(RUNLINT) --rcfile=$(PWD)/.pylintrc $(PWD)/src/endpoint.py
	
tag: build
	$(RUNDOCKER) $(REGISTRY)/$(NAMESPACE)/$(CONTAINER) $(REGISTRY):9000/$(NAMESPACE)/$(CONTAINER)

push: tag
	$(RUNDOCKER) $(REGISTRY):9000/$(NAMESPACE)/$(CONTAINER)
	
run: build
	$(RUNDOCKER) -d --name=$(PROJECT) -p 8000:8000 $(REGISTRY)/$(CONTAINER)

kill:
	-$(RUNDOCKER) $(PROJECT)

rm: kill
	-$(RUNDOCKER) $(PROJECT)

deploy:
	$(RUNCOMPOSE) up -d 