# sixeleven-abe docker image

# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.19
MAINTAINER Paul Oliver <docker@paultastic.com>
ENV REFRESHED_AT 20161202

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# install python
RUN apt-get -yqq update 
RUN apt-get -yqq install git sqlite sudo wget python-dev python-flup python-crypto

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# git clone bitcoin-abe to be a local block explorer
WORKDIR /home
RUN git clone https://github.com/fflo/bitcoin-abe sixeleven-abe

# build bitcoin-abe, it requires a patch to be run within docker
WORKDIR /home/sixeleven-abe
ADD ./bitcoinabe.abe.py.patch /home/sixeleven-abe/abe.py.patch
RUN patch -p1 < abe.py.patch
RUN python setup.py install

ADD ./sqlite.conf /home/sixeleven-abe/
ADD ./run.server.sh /home/sixeleven-abe/

RUN chmod 755 /home/sixeleven-abe run.server.sh

EXPOSE 80

CMD ["/home/sixeleven-abe/run.server.sh"]
