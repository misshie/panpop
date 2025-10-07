FROM ubuntu:24.04

LABEL maintainer="Hiroyuki Mishima <hmishima@nagasaki-u.ac.jp>"
LABEL version="1.0"
LABEL description="Container for PanPop (https://github.com/starskyzheng/panpop/)"

ENV DEBIAN_FRONTEND=noninteractive \
    PATH="/app/bin:/opt/bcftools-1.22:${PATH}"

RUN apt-get update && \
    apt-get install -y \
    perl \
    build-essential \
    cpanminus \
    git \
    curl \
    zlib1g-dev \
    liblzma-dev \
    libbz2-dev \
    libcurl4-openssl-dev \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/* \
    && mkdir -p /opt \
    && cd /opt \
    && curl -sL https://github.com/samtools/bcftools/releases/download/1.22/bcftools-1.22.tar.bz2 | tar -jxv \
    && cd /opt/bcftools-1.22 \
    && make

WORKDIR /app

COPY . .

RUN cpanm --installdeps .

# ENTRYPOINT ["perl", "bin/PART_run.pl"]
# CMD ["--help"]