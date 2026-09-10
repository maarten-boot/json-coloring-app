# jy - a viewer for JSON and YAML.  `make help` lists the targets.

PYTHON ?= python3
FILE ?=

.DEFAULT_GOAL := help

help:  ## list these targets
	@grep -hE '^[a-z][a-z-]*:.*## ' $(MAKEFILE_LIST) \
		| awk -F':.*## ' '{printf "  make %-14s %s\n", $$1, $$2}'

install:  ## runtime dependencies
	$(PYTHON) -m pip install -r requirements.txt

install-dev:  ## runtime dependencies plus pytest and ruff
	$(PYTHON) -m pip install -r requirements-dev.txt

run:  ## start jy, optionally on a file: make run FILE=report.rl.json
	$(PYTHON) jy.py $(if $(FILE),--file=$(FILE))

demo:  ## open the sample OpenAPI spec
	$(PYTHON) jy.py --file=examples/openapi.yaml

test:  ## the whole suite
	$(PYTHON) -m pytest

test-fast:  ## only the tests that need no display
	$(PYTHON) -m pytest -m "not gui"

test-gui:  ## only the widget tests
	$(PYTHON) -m pytest -m gui

test-headless:  ## the whole suite under a virtual display
	xvfb-run -a $(PYTHON) -m pytest

prep: clean format check lint

lint:  ## report style problems
	ruff check .

format:  ## rewrite the code the way ruff wants it
	ruff format .

check:  ## before committing: formatting, lint, then the display-free tests
	ruff format --check .
	ruff check .
	$(PYTHON) -m pytest -m "not gui"

clean:  ## remove caches
	rm -rf .pytest_cache .ruff_cache
	find . -name __pycache__ -type d -prune -exec rm -rf {} +

.PHONY: help install install-dev run demo test test-fast test-gui test-headless lint format check clean
