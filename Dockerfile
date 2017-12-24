ARG runtime="nvidia"
FROM nvidia/cuda:8.0-runtime-ubuntu16.04

LABEL maintainer="Chris Diehl <cultclassik@gmail.com>"

# NVidia required
ENV NVIDIA_VISIBLE_DEVICES=0

#ENV EWORKER="myminer"
ENV EPOOL1="us2.ethermine.org:4444"
ENV EPOOL2="us1.ethermine.org:4444"
#ENV ETHACCT="0x96ae82e89ff22b3eff481e2499948c562354cb23"
#ENV EWALL="${ETHACCT}.${EWORKER}"
ENV EWALL="eth_acct.eth_worker"
ENV ETHI=8
#ENV DWORKER="myminer"
ENV DPOOL="stratum+tcp://lbry.suprnova.cc:6256"
#ENV DACCT="cultclassik"
#ENV DWALL="${DACCT}.${DWORKER}"
ENV DWALL="lbc_acct.lbc_worker"
ENV DCRI=8

ENV CMREL="https://s3-us-west-1.amazonaws.com/mastermine/minebox/claymore_Ethereum%2BDecred_Siacoin_Lbry_Pascal_gpu_v10.2_LINUX.tar.gz"

ENV GPU_FORCE_64BIT_PTR=0
ENV GPU_MAX_HEAP_SIZE=100
ENV GPU_USE_SYNC_OBJECTS=1
ENV GPU_MAX_ALLOC_PERCENT=100
ENV GPU_SINGLE_ALLOC_PERCENT=100

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    ocl-icd-opencl-dev \
    libcurl3 && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /claymore
WORKDIR /claymore

RUN wget --no-check-certificate $CMREL &&\
    ls -la &&\
    tar -xvf ./*.tar.gz -C /claymore --strip-components 1 &&\
    rm *.tar.gz

RUN chmod +x /claymore/ethdcrminer64
ADD script/miner.sh /claymore/
RUN chmod +x /claymore/miner.sh

EXPOSE 3333/tcp

ENTRYPOINT /claymore/miner.sh