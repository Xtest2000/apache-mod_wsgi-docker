FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y systemd perl wget tzdata tar chrony python3.10 python3.10-venv python3.10-dev build-essential libpcre3 libpcre3-dev libapr1 libaprutil1 libapr1-dev libaprutil1-dev

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY chrony.conf /etc/chrony/chrony.conf

RUN cd /tmp && wget https://dlcdn.apache.org/httpd/httpd-2.4.62.tar.gz \
&& wget https://dlcdn.apache.org//apr/apr-1.7.5.tar.gz && wget https://dlcdn.apache.org//apr/apr-util-1.6.3.tar.gz \
&& tar -zvxf httpd-2.4.62.tar.gz && tar -zvxf apr-1.7.5.tar.gz && tar -zvxf apr-util-1.6.3.tar.gz && mv apr-1.7.5 httpd-2.4.62/srclib/apr && mv apr-util-1.6.3 httpd-2.4.62/srclib/apr-util \
&& cd httpd-2.4.62 && ./configure --with-included-apr --with-pcre=/usr && make && make install
