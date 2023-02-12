FROM r0bert0lol/ubuntu-22-04-tfs-1-4:latest

RUN export DEBIAN_FRONTEND=noninteractive \
	&& ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

RUN apt-get update -y

RUN apt-get upgrade -y

VOLUME [ "/srv" ]