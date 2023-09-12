# Variables
DATE := $(shell date "+%y%m%d")
IMAGE_NAME = registry.cloud.ainode.ai/unist-4th/base:$(DATE)

# Docker
build.log: $(wildcard Docker/*) | log Output
	rm -fv $@
	docker images | grep $(IMAGE_NAME) && docker rmi $(IMAGE_NAME) || true
	docker build --rm --tag $(IMAGE_NAME) Docker | tee $@
	docker push $(IMAGE_NAME)
