FROM ubuntu:24.04

LABEL maintainer="Hiroyuki Mishima <hmishima@nagasaki-u.ac.jp>"
LABEL version="1.0"
LABEL description="Container for PanPop (https://github.com/starskyzheng/panpop/)"

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH=/opt/samtools-1.22.1:/app/misc:/app/bin:${PATH}
ENV TEMPDIR=/tmp
ENV TMP=/tmp
ENV TEMP=/tmp
ENV LANG=C

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    perl \
    build-essential \
    cpanminus \
    ca-certificates \	
    curl \
    zlib1g-dev \
    liblzma-dev \
    libbz2-dev \
    libcurl4-openssl-dev \
    libncurses-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

RUN mkdir -p /opt && \
    cd /opt/ && \
    curl -sSL https://github.com/samtools/samtools/releases/download/1.22.1/samtools-1.22.1.tar.bz2 | tar jx && \
    cd samtools-1.22.1 && \
    make && \
    make clean
    
WORKDIR /app
COPY . .
RUN cpanm --installdeps .

# ENTRYPOINT ["perl", "bin/PART_run.pl"]
# CMD ["--help"]
