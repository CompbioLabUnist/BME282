#!/bin/bash
docker pull fumire/bme282:latest
docker run --rm -it --volume /BiO/Live/pbj1862/RNAseq_Example/Analysis/00.bamtofq/Cancer_Group:/Cancer:ro --volume /BiO/Live/pbj1862/RNAseq_Example/Analysis/00.bamtofq:/Normal:ro --volume /BiO2/Research/UNIST-KabukiSyndrome_PNUYH_CCK-2022-12/Resource/RSEM:/Reference/RSEM:ro --volume /BiO/Share/Tools/gatk-bundle/hg38:/Reference/gatk-bundle:ro --volume $(realpath .):/Working fumire/bme282:latest /bin/bash
