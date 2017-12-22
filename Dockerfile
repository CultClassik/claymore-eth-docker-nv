ARG runtime="nvidia"
FROM nvidia/cuda:8.0-runtime-ubuntu16.04

MAINTAINER Chris Diehl <cultclassik@gmail.com>

# NVidia required
ENV NVIDIA_VISIBLE_DEVICES=0

ENV EWORKER="myminer"
ENV EPOOL1="us2.ethermine.org:4444"
ENV EPOOL2="us1.ethermine.org:4444"
ENV ETHACCT="0x96ae82e89ff22b3eff481e2499948c562354cb23"
ENV EWALL="${ETHACCT}.${WORKER}"

ENV DWORKER="myminer"
ENV DPOOL="stratum+tcp://lbry.suprnova.cc:6256"
ENV DACCT="cultclassik"
ENV DWALL="${DACCT}.${DWORKER}"
ENV MPORT="3333"

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
RUN touch /claymore/go-mining.sh
ADD script/go-mining.sh /claymore/
RUN chmod +x /claymore/go-mining.sh

EXPOSE 3333/tcp

CMD [ "/claymore/go-mining.sh" ]