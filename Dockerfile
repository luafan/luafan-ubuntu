FROM ubuntu:14.04

RUN cd && apt-get update && apt-get install -y wget lua5.1-dev lua5.1 luajit make gcc libc-dev libcurl4-openssl-dev libevent-dev git libevent-2.0-5 libevent-core-2.0-5 libevent-extra-2.0-5 libevent-openssl-2.0-5 libcurl3 cmake g++ bison libncurses5-dev libssl-dev && rm -rf luarocks-2.3.0.tar.gz && wget http://luarocks.org/releases/luarocks-2.3.0.tar.gz && tar xzf luarocks-2.3.0.tar.gz && cd luarocks-2.3.0 && ./configure && make build && make install && cd .. && rm -rf luarocks-2.3.0* && wget https://github.com/MariaDB/server/archive/mariadb-5.5.48.tar.gz && tar xzf mariadb-5.5.48.tar.gz && cd server-mariadb-5.5.48 && cmake . && cd libmysql && make install && cd ../include && make install && cd && rm -rf mariadb-5.5.48.tar.gz server-mariadb-5.5.48 && luarocks install luafan MARIADB_DIR=/usr/local/mysql && apt-get -y remove g++ bison libncurses5-dev lua5.1-dev libc-dev libssl-dev libcurl4-openssl-dev libevent-dev cmake make gcc binutils libc-dev-bin git && apt-get -y autoremove && rm -rf /usr/local/mysql/lib/*.a /var/lib/apt/lists/*

WORKDIR /root/
