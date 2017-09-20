# Shadowsocks for MiWifi 3

Mostly copy from: [blademainer/miwifi-ss](https://github.com/blademainer/miwifi-ss), thanks!

Replaced `ss-redir` with a new (2017-09-20) from `opkg`.

Install:

```
cd /data
curl https://codeload.github.com/winguse/miwifi_3_ss/zip/master -o ss.zip
unzip ss.zip
rm ss.zip
cd miwifi_3_ss-master
chmod +x *.sh
./install.sh
```