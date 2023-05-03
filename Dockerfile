FROM ubuntu:22.04

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN cd && apt update \
    && apt install -y libsqlite3-0 libsqlite3-dev tzdata wget liblua5.3-dev lua5.3 unzip zlib1g-dev luajit make gcc libc-dev libcurl4-openssl-dev libcurl4 libevent-dev git libevent-2.1-7 libevent-core-2.1-7 libevent-extra-2.1-7 libevent-openssl-2.1-7 cmake g++ bison libncurses5-dev \
    && rm -rf luarocks-3.7.0.tar.gz && wget http://luarocks.org/releases/luarocks-3.7.0.tar.gz && tar xzf luarocks-3.7.0.tar.gz && cd luarocks-3.7.0 && ./configure && make build && make install && cd \
    && wget https://github.com/MariaDB/server/archive/mariadb-5.5.48.tar.gz && tar xzf mariadb-5.5.48.tar.gz && cd server-mariadb-5.5.48 && cmake . && cd libmysql && make install && cd ../include && make install && cd && rm -rf mariadb-5.5.48.tar.gz server-mariadb-5.5.48 \
    && wget https://www.openssl.org/source/openssl-1.1.1q.tar.gz && tar xzf openssl-1.1.1q.tar.gz && cd openssl-1.1.1q && ./config && make && make install && cd \
    && luarocks install luafan MARIADB_DIR=/usr/local/mysql CURL_INCDIR=/usr/include/`uname -m`-linux-gnu \
    && luarocks install compat53 && luarocks install lpeg && luarocks install lua-cjson 2.1.0-1 && luarocks install luafilesystem \
    && luarocks install lzlib && luarocks install openssl && luarocks install lbase64 \
    && luarocks install lua-protobuf \
    && luarocks install lmd5 \
    && luarocks install lua-iconv \
    && luarocks install lsqlite3 \
    && cd luarocks-3.7.0 && make uninstall && cd && rm -rf luarocks-3.7.0* \
    && apt-get -y remove g++ bison libncurses5-dev liblua5.3-dev libc-dev zlib1g-dev libcurl4-openssl-dev libevent-dev unzip cmake make gcc binutils libc-dev-bin git \
    && apt-get -y autoremove \
    && cd && rm -rf openssl-1.1.1q* /usr/local/share/doc /usr/local/mysql/lib/*.a /var/lib/apt/lists/*

WORKDIR /root/
