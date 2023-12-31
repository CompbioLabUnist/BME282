FROM ubuntu:22.04
USER root
WORKDIR /
LABEL maintainer="jwlee230@unist.ac.kr"

# Set time zone
RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# APT
RUN apt-get update && apt-get upgrade -y && apt-get install -y software-properties-common python3 python3-pip python3-wheel r-base r-base-core r-recommended r-base-dev samtools bcftools tabix bowtie2 openjdk-17-jdk perl cpanminus mysql-server autoconf cmake make gcc g++ cl-sql-sqlite3 sqlitebrowser libtool libcurl4-openssl-dev libssl-dev libxml2-dev libfontconfig1-dev libcairo2-dev fastqc libmysqlclient-dev libavcodec58 liblog4j2-java libcommons-configuration2-java-doc libcommons-compress-java libjettison-java libplexus-utils-java curl wget tree unzip less vim screen && apt-get clean

# Python
ADD requirements.txt /requirements.txt
RUN pip3 install pip==23.3 && pip3 install --no-cache-dir --requirement /requirements.txt && ln -s /usr/bin/python3 /usr/bin/python

# R
RUN mkdir -p $HOME/.R && echo "MAKEFLAGS = -j" > $HOME/.R/Makevars && Rscript -e 'install.packages(c("BiocManager", "remotes", "blockmodeling"))' -e "BiocManager::install(c('GenomicRanges', 'XML', 'GenomeInfoDb', 'Biostrings', 'RCurl', 'Rsamtools', 'GenomicAlignments', 'restfulr', 'ggtree'))" -e 'BiocManager::install("rtracklayer")' -e 'BiocManager::install("DESeq2")' -e 'BiocManager::install("enrichplot")' -e "install.packages(c('pbdZMQ', 'repr', 'devtools'))" -e 'install.packages(c("openxlsx", "ggrepel", "tidyverse", "ggstance", "enrichR", "enrichplot", "forcats", "IRdisplay", "IRkernel"))' -e 'BiocManager::install(c("NOISeq", "UniProt.ws"))'
ENV R_LIBS=/usr/local/lib/R/site-library:/usr/lib/R/site-library:/usr/lib/R/library

# STAR
RUN wget "https://github.com/alexdobin/STAR/releases/download/2.7.11a/STAR_2.7.11a.zip" && unzip STAR_2.7.11a.zip && rm /STAR_2.7.11a.zip
ENV PATH=/STAR_2.7.11a/Linux_x86_64:$PATH

# RSEM
RUN wget "https://github.com/deweylab/RSEM/archive/refs/tags/v1.3.3.zip" && unzip v1.3.3.zip && cd RSEM-1.3.3 && make -j && make ebseq -j && rm /v1.3.3.zip
ENV PATH=/RSEM-1.3.3:$PATH

# Fastq Screen
RUN wget "https://github.com/StevenWingett/FastQ-Screen/archive/refs/tags/v0.15.3.zip" && unzip v0.15.3.zip && rm /v0.15.3.zip
ENV PATH=/FastQ-Screen-0.15.3:$PATH

# GATK
RUN wget "https://github.com/broadinstitute/gatk/releases/download/4.4.0.0/gatk-4.4.0.0.zip" && unzip gatk-4.4.0.0.zip && rm /gatk-4.4.0.0.zip
ENV PATH=/gatk-4.4.0.0:$PATH

# VCFTOOLS
RUN wget "https://github.com/vcftools/vcftools/releases/download/v0.1.16/vcftools-0.1.16.tar.gz" && tar -zxvf vcftools-0.1.16.tar.gz && cd vcftools-0.1.16 && ./configure && make -j && make -j install && rm /vcftools-0.1.16.tar.gz

# VEP
ENV KENT_SRC="/kent-454_base/src" MACHTYPE="x86_64" CFLAGS="-fPIC"
RUN wget "https://github.com/ucscGenomeBrowser/kent/archive/refs/tags/v454_base.zip" && unzip v454_base.zip && cd kent-454_base/src/lib && make -j && cd ../jkOwnLib && make -j && rm /v454_base.zip
RUN wget "https://github.com/Ensembl/ensembl-vep/archive/refs/tags/release/110.1.zip" && unzip 110.1.zip && cd ensembl-vep-release-110.1 && cpanm --with-recommends --notest --installdeps . && perl INSTALL.pl --NO_TEST --NO_UPDATE && rm /110.1.zip
# perl INSTALL.pl --AUTO ac --SPECIES "GRCh38" --NO_TEST --NO_UPDATE
ENV PATH=/ensembl-vep-release-110.1:$PATH

# VCF2MAF
RUN wget "https://github.com/mskcc/vcf2maf/archive/refs/tags/v1.6.21.zip" && unzip v1.6.21.zip && cd vcf2maf-1.6.21 && chmod +x *.pl && rm /v1.6.21.zip
ENV PATH=/vcf2maf-1.6.21:$PATH

CMD /bin/bash
