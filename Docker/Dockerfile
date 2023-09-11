FROM zerooneai/tensorflow:tensorflow-2.7.0-jupyter
USER root
WORKDIR /
LABEL maintainer="jwlee230@unist.ac.kr"

# Set time zone
RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# APT
RUN apt-get update && apt-get upgrade -y && apt-get install -y python3 python3-pip python3-wheel r-base r-base-core r-recommended r-base-dev samtools bcftools tabix openjdk-17-jdk perl cpanminus autoconf cmake make gcc g++ libcurl4-openssl-dev libssl-dev libxml2-dev libfontconfig1-dev libcairo2-dev curl wget tree unzip less

# Python
ADD requirements.txt /requirements.txt
RUN pip3 install --requirement /requirements.txt

# R
RUN mkdir -p $HOME/.R && echo "MAKEFLAGS = -j" > $HOME/.R/Makevars && Rscript -e 'install.packages(c("BiocManager", "remotes", "blockmodeling"))' -e "BiocManager::install(c('GenomicRanges', 'XML', 'GenomeInfoDb', 'Biostrings', 'RCurl', 'Rsamtools', 'GenomicAlignments', 'restfulr', 'ggtree'))" -e 'BiocManager::install("rtracklayer")' -e 'BiocManager::install("DESeq2")' -e 'BiocManager::install("enrichplot")'
ENV R_LIBS=/usr/local/lib/R/site-library:/usr/lib/R/site-library:/usr/lib/R/library

# STAR
RUN wget "https://github.com/alexdobin/STAR/releases/download/2.7.11a/STAR_2.7.11a.zip" && unzip STAR_2.7.11a.zip
ENV PATH=/STAR_2.7.11a/Linux_x86_64:$PATH

# RSEM
RUN wget "https://github.com/deweylab/RSEM/archive/refs/tags/v1.3.3.zip" && unzip v1.3.3.zip && cd RSEM-1.3.3 && make -j && make ebseq -j
ENV PATH=/RSEM-1.3.3:$PATH

# Volume
VOLUME /Output
VOLUME /Data

CMD ["/bin/bash"]
