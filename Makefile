# Makefile

RUNPYTHON = $(shell which python)
RUNLINT = $(shell which pylint)
RUNPIP = $(shell which pip)

VERSION = $(shell git rev-parse --short HEAD) 
BRANCH = $(shell git rev-parse --abbrev-ref HEAD)

TEMEXPORTER_PORT=8888

all: login build tag push
 
lint: 
	$(RUNLINT) --rcfile=$(PWD)/.pylintrc $(PWD)/src/endpoint.py

requirements:
	$(RUNPIP) install -r lib/requirements.txt --user

run: 
	$(RUNPYTHON) src/endpoint.py