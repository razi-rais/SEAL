# Dockerfile | SealExamples
# Source (with some modifications): https://github.com/Lab41/PySEAL/blob/master/Dockerfile

FROM ubuntu:16.04 
# Install binary dependencies
RUN apt-get -qqy update && apt-get install -qqy \
    g++ \
    git \
    make \
    --no-install-recommends

RUN mkdir -p SEAL/
COPY /SEAL/ /SEAL/SEAL/
WORKDIR /SEAL/SEAL/
RUN chmod +x configure
RUN sed -i -e 's/\r$//' configure
RUN ./configure
RUN make
ENV LD_LIBRARY_PATH SEAL/bin:$LD_LIBRARY_PATH
COPY /SEALExamples /SEAL/SEALExamples
WORKDIR /SEAL/SEALExamples
RUN make
WORKDIR /SEAL

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
