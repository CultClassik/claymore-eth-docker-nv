#!/bin/bash

cd /claymore

echo "POOL: ${EPOOL1}, WALLET: ${EWALL}, PSW: x, WORKER: anonymous, ESM: 0, ALLPOOLS: 1" > epools.txt
echo "POOL: ${EPOOL2}, WALLET: ${EWALL}, PSW: x, WORKER: anonymous, ESM: 0, ALLPOOLS: 1" >> epools.txt
echo "POOL: ${DPOOL}, WALLET: ${DWALL}, PSW: x, WORKER: anonymous, ESM: 0, ALLPOOLS: 1" > dpools.txt

#echo "-epool ${EPOOL1}" > config.txt
#echo "-ewal ${EWALL}" >> config.txt
#echo "-epsw x" >> config.txt
#echo "-dcoin lbc" >> config.txt
#echo "-dpool ${DPOOL}" >> config.txt
#echo "-dwal ${DWALL}" >> config.txt
#echo "-dpsw x" >> config.txt
#echo "-mport ${MPORT}" >> config.txt
#echo "-dcri 12" >> config.txt

./ethdcrminer64 \
  -epool ${EPOOL1} \
  -ewal ${EWALL} \
  -epsw x \
  -ethi ${ETHI} \
  -dcoin lbc \
  -dpool ${DPOOL} \
  -dwal ${DWALL} \
  -dpsw x \
  -dcri ${DCRI} \
  -mport 3333