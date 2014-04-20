#######################################################################
# Dockerfile to build a Crate.io container image
# Based on Ubuntu
#######################################################################

# Set the base image to Ubuntu
# FROM orchardup/jenkins
FROM ubuntu:12.04

# File Author / Maintainer
MAINTAINER oreomitch <oreomitch@gmail.com>

RUN apt-get update

RUN apt-get install python-software-properties -y

# Add oracle-jdk6 to repositories

# Never ask for confirmations
ENV DEBIAN_FRONTEND noninteractive
RUN echo "debconf shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections
RUN echo "debconf shared/accepted-oracle-license-v1-1 seen true" | /usr/bin/debconf-set-selections
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN apt-get install oracle-java7-installer -y
RUN apt-get install oracle-java7-set-default -y

RUN echo "deb http://ftp.wa.co.za/ubuntu precise universe" > /etc/apt/sources.list
RUN echo "deb http://ftp.wa.co.za/ubuntu precise-updates universe" >> /etc/apt/sources.list
RUN echo "deb http://ftp.wa.co.za/ubuntu precise-backports universe" >> /etc/apt/sources.list
RUN echo "deb http://ftp.wa.co.za/ubuntu precise-security universe" >> /etc/apt/sources.list
RUN echo deb http://archive.ubuntu.com/ubuntu precise universe >> /etc/apt/sources.list

RUN apt-get update
RUN add-apt-repository ppa:crate/stable
RUN apt-get update

VOLUME ["/etc/ssl/certs"]
RUN apt-get install -y crate

ENV CRATE_HOME /usr/share/crate
ENV PATH $CRATE_HOME:$PATH
ENV CRATE_CLASSPATH $CRATE_HOME/bin
EXPOSE 4200

CMD ["/usr/share/crate/bin/crate", "-Des.config=/etc/crate/crate.yml"]
## END
