# Dockerfile
FROM ubuntu:latest as env-build

RUN apt update -y && apt install -y git && git clone https://github.com/aligungr/UERANSIM.git &&  apt install make -y && apt install gcc -y && \
 apt install g++ -y  && \
  apt install build-essential libssl-dev -y && apt-get install wget unzip zip -y && \
  wget https://github.com/Kitware/CMake/releases/download/v3.25.0/cmake-3.25.0.tar.gz &&  \
  tar zxvf cmake-3.25.0.tar.gz && cd cmake-3.25.0 && ./bootstrap && make && \
  make install && apt install libsctp-dev lksctp-tools iproute2 -y && cd ../UERANSIM && make
  
FROM ubuntu:latest

COPY --from=env-build /UERANSIM/build/* /usr/local/bin/
RUN mkdir /etc/ueransim
COPY ue.yaml /etc/ueransim/ue.yaml
COPY entrypoint.sh /entrypoint.sh

RUN apt update -y -q && apt install -y -q  tcpdump iptables iputils-ping traceroute build-essential bind9utils   bind9-doc   dnsutils    curl     gettext     iperf3     libsctp-dev lksctp-tools iproute2  # buildkit

ENV N2_IFACE=eth0
ENV N3_IFACE=eth0
ENV RADIO_IFACE=eth0
ENV AMF_HOSTNAME=amf	
ENV GNB_HOSTNAME=localhost

COPY . /workdir
WORKDIR /workdir
RUN ./install.sh docker

EXPOSE 8080
EXPOSE 502

ENTRYPOINT ["/entrypoint.sh"]
