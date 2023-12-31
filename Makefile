# Variables
DATE := $(shell date "+%Y%m%d")
IMAGE_NAME = registry.cloud.ainode.ai/unist-4th/base

# Docker
build.log: $(wildcard Docker/*)
	rm -fv $@
	docker build --rm --tag $(IMAGE_NAME):$(DATE) Docker | tee $@
	docker push $(IMAGE_NAME):$(DATE)

# Docker (Ubuntu)
build-ubuntu.log: $(wildcard Docker-ubuntu/*)
	rm -fv $@
	docker build --rm --tag bme282:$(DATE) Docker-ubuntu | tee $@

run:
	echo "#!/bin/bash\nmake -C $(abspath .) build.log" > tmp.sh
	sbatch --chdir=$(abspath .) --cpus-per-task=1 --error="$(abspath .)/%x.e%A" --job-name="BME282_$(DATE)" --mail-type=ALL --mail-user="jwlee230@compbio.unist.ac.kr" --mem=10G --output="$(abspath .)/%x.o%A" --export=ALL tmp.sh
	rm tmp.sh
.PHONY: run
