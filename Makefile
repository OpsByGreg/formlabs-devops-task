# Optional command line arguments
dockerfile ?= helloapp.Dockerfile
port ?= 8080
image-name ?= helloapp
image-tag ?= 0.0.1
build ?= true

# Set full image name
image := $(image-name):$(image-tag)

# Allow 'build=false' to be passed skipping
# a rebuild of the docker image.
build-true = build
build-false =
build-dependency := $(build-$(build))

# Ensure the intended targets are run
.PHONY: build test run shell

build:
	docker build --tag $(image) --file $(dockerfile) .

test: $(build-dependency)
	docker run --rm -t $(image) test

run: $(build-dependency)
	docker run --rm -t -p $(port):8080 $(image) run

shell: $(build-dependency)
	docker run --rm -it --entrypoint "/bin/bash" $(image)
