FROM ubuntu:20.04

RUN export DEBIAN_FRONTEND=noninteractive \
	&& ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

RUN apt-get update -y

RUN apt-get upgrade -y

RUN apt-get -y install tzdata

# 1: forgottenserver (TFS)
RUN apt-get -y install git cmake build-essential libluajit-5.1-dev zip ca-certificates pkg-config autoconf libmariadb-dev-compat libboost-date-time-dev libboost-filesystem-dev libboost-system-dev libboost-iostreams-dev libpugixml-dev libcrypto++-dev libfmt-dev


VOLUME [ "/srv" ]