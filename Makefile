# Variables
DATE := $(shell date "+%Y%m%d")
IMAGE_NAME = docker.io/fumire/bme282

# Docker
build.log: $(wildcard Docker/*)
	rm -fv $@
	docker build --rm --tag $(IMAGE_NAME):$(DATE) Docker | tee $@
	docker push $(IMAGE_NAME):$(DATE)
	docker build --rm --tag $(IMAGE_NAME) Docker
	docker push $(IMAGE_NAME)

run:
	echo "#!/bin/bash\nmake -C $(abspath .) build.log" > tmp.sh
	sbatch --chdir=$(abspath .) --cpus-per-task=1 --error="$(abspath .)/%x.e%A" --job-name="BME282_$(DATE)" --mail-type=ALL --mail-user="jwlee230@compbio.unist.ac.kr" --mem=10G --output="$(abspath .)/%x.o%A" --export=ALL tmp.sh
	rm tmp.sh
.PHONY: run
