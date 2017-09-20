#!/bin/bash

# check https://github.com/shadowsocks/openwrt-shadowsocks/releases

export BASE_URL=https://dl.bintray.com/aa65535/opkg/shadowsocks-libev/3.1.0/OpenWrt/ramips/

rm -r ./usr
rm -r ./tmp
mkdir ./tmp
cd ./tmp

curl $BASE_URL \
    | grep ".ipk" \
    | sed 's/^[^:]*:\([^"]*\)".*$/\1/g' \
    | awk -v BASE_URL=$BASE_URL -F: '{ \
        system("curl " BASE_URL $0 " | tar xvz"); \
        system("tar xvzf data.tar.gz"); \
        system("rm -f *.tar.gz"); \
    }'

curl https://downloads.openwrt.org/chaos_calmer/15.05.1/ramips/mt7620/packages/packages/rng-tools_5-1_ramips_24kec.ipk \
    | tar xvz
tar xvzf data.tar.gz
rm -f *.tar.gz

cd ..

mv tmp/usr .
mv tmp/sbin/rngd  ./usr/bin/

ln -s /usr/lib/libpcre.so.0.0.1 ./usr/lib/libpcre.so.1

rm -r tmp
