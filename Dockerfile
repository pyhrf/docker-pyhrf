FROM ubuntu:latest
LABEL maintainer="arias@lipn.univ-paris13.fr"

# Build PyHRF from a specific branch
ARG PYHRF_BRANCH=master

# Update the image and install some tools
RUN apt-get update --fix-missing && \
    apt-get install -y tzdata && \
    apt-get -y dist-upgrade && \
    apt-get install -y git gosu pkg-config libfreetype6 libfreetype6-dev libatlas-base-dev gfortran \
        libpng-dev imagemagick python-pip python-tk && \
    apt-get clean autoclean && \
    apt-get autoremove --purge -y && \
    pip install -U setuptools nose coverage coveralls twine

# Download and Install PyHRF
RUN git clone -b $PYHRF_BRANCH https://github.com/pyhrf/pyhrf.git && \
    cd pyhrf && python setup.py install && \
    python setup.py sdist bdist_wheel && cp -r dist / && \
    cd .. && rm -rf pyhrf

# Adding script to set the write and read permissions to mounted volumes
ADD entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
