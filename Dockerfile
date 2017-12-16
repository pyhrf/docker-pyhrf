FROM ubuntu:latest
MAINTAINER Jaime Arias "jaime.arias@inria.fr"

# Build PyHRF from a specific branch
ARG PYHRF_BRANCH=master
ARG DEPLOY=false

# Update the image and install some tools
RUN apt-get update --fix-missing && \
    apt-get -y dist-upgrade && \
    apt-get install -y git gosu pkg-config libfreetype6 libfreetype6-dev libatlas-dev libatlas-base-dev gfortran \
        libpng-dev python-pip imagemagick python-tk && \
    apt-get clean autoclean && \
    apt-get autoremove --purge -y && \
    pip install -U pip setuptools nose coverage coveralls

# Download and Install PyHRF
RUN git clone -b $PYHRF_BRANCH https://github.com/pyhrf/pyhrf.git && cd pyhrf && \
    if [ "$DEPLOY" = false ]; then python setup.py install && cd .. && rm -rf pyhrf; else python setup.py sdist bdist_wheel; fi

# Adding script to set the write and read permissions to mounted volumes
ADD entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
