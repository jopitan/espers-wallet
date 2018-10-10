FROM ubuntu:18.04 as builder
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y build-essential unzip libdb-dev libdb++-dev libboost-all-dev libqrencode-dev git binutils libcurl4-openssl-dev openssl libssl-dev libminiupnpc-dev wget
RUN apt-get install -y libssl1.0-dev
RUN git clone https://github.com/CryptoCoderz/Espers.git /opt/espers
RUN chmod +x /opt/espers/src/leveldb/build_detect_platform \
	&& cd /opt/espers/src \
	&& make -f makefile.unix USE_UPNP=0
RUN cp /opt/espers/src/Espersd /opt/Espersd \
	&& rm -rf /opt/espers \
	&& chmod +x /opt/Espersd

FROM alpine:latest
RUN apk add wget && apk add unzip
RUN mkdir ~/.ESP && cd ~/.ESP
COPY --from=builder /opt/Espersd /opt/Espersd
COPY configs/Espers.conf /root/.ESP/Espers.conf
COPY shells/start-daemon.sh /opt/start-daemon.sh
RUN chmod +x /opt/start-daemon.sh
CMD ["/bin/sh", "-c", "/opt/start-daemon.sh"]
