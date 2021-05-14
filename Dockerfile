FROM ubuntu:20.04

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN cd && apt-get update \
    && apt install -y tzdata wget lua5.3-dev lua5.3 unzip luajit make gcc libc-dev libcurl4-openssl-dev libcurl4 libevent-dev git libevent-2.1-7 libevent-core-2.1-7 libevent-extra-2.1-7 libevent-openssl-2.1-7 cmake g++ bison libncurses5-dev libssl-dev \
    && rm -rf luarocks-3.7.0.tar.gz && wget http://luarocks.org/releases/luarocks-3.7.0.tar.gz && tar xzf luarocks-3.7.0.tar.gz && cd luarocks-3.7.0 && ./configure && make build && make install && cd .. && rm -rf luarocks-3.7.0* \
    && wget https://github.com/MariaDB/server/archive/mariadb-5.5.48.tar.gz && tar xzf mariadb-5.5.48.tar.gz && cd server-mariadb-5.5.48 && cmake . && cd libmysql && make install && cd ../include && make install && cd && rm -rf mariadb-5.5.48.tar.gz server-mariadb-5.5.48 \
    && luarocks install luafan MARIADB_DIR=/usr/local/mysql CURL_INCDIR=/usr/include/x86_64-linux-gnu \
    && apt-get -y remove g++ bison libncurses5-dev lua5.3-dev libc-dev libssl-dev libcurl4-openssl-dev libevent-dev unzip cmake make gcc binutils libc-dev-bin git \
    && apt-get -y autoremove \
    && rm -rf /usr/local/mysql/lib/*.a /var/lib/apt/lists/*

WORKDIR /root/
