# Optional command line arguments
dockerfile ?= helloapp.Dockerfile
port ?= 8080
image-name ?= helloapp
image-tag ?= 0.0.1
build ?= true
namespace ?= helloapp
service ?= helloapp-service

# Set full image name
image := $(image-name):$(image-tag)

# Allow 'build=false' to be passed skipping
# a rebuild of the docker image.
build-true = build
build-false =
build-dependency := $(build-$(build))

# Ensure all targets are PHONY
# https://stackoverflow.com/a/63784549q
.PHONY: $(shell sed -n -e '/^$$/ { n ; /^[^ .\#][^ ]*:/ { s/:.*$$// ; p ; } ; }' $(MAKEFILE_LIST))

build:
	docker build --tag $(image) -f $(dockerfile) .

test: $(build-dependency)
	docker run --rm -t $(image) test

run: $(build-dependency)
	docker run --rm -it -p $(port):8080 $(image) run

shell: $(build-dependency)
	docker run --rm -it --entrypoint "/bin/bash" $(image)

minikube-load-image:
	minikube image load $(image)

create-namespace:
	kubectl create namespace $(namespace) --dry-run=client -o yaml | kubectl apply -f -

create-deployment:
	kubectl create -f manifests/deploy.yaml --namespace $(namespace)

delete-deployment:
	kubectl delete -f manifests/deploy.yaml --namespace $(namespace)

create-service:
	kubectl create -f manifests/service.yaml --namespace $(namespace)

delete-service:
	kubectl delete -f manifests/service.yaml --namespace $(namespace)

minikube-expose-service:
	minikube service $(service) --namespace $(namespace) --url

# Assumes minikube-load-image has run previously
k8s-create: create-namespace create-deployment create-service minikube-expose-service

k8s-delete: delete-service delete-deployment
