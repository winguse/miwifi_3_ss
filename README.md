# Shadowsocks for MiWifi 3

Mostly copy from: [blademainer/miwifi-ss](https://github.com/blademainer/miwifi-ss), thanks!

Replaced `ss-redir` with latest (v3.1.0, 2017-09-21) [openwrt-shadowsocks](https://github.com/shadowsocks/openwrt-shadowsocks/releases).

## Pre requirements
- Setup the router
- Download a App in mobile phone for associate the Xiaomi account with the router
- Upgrade to dev channel of the framework: http://www1.miwifi.com/miwifi_download.html (download and upload to the router web config page)
- Visit: https://d.miwifi.com/rom/ssh, follow the instruction for root the device

## Install

```shell
cd /data
curl https://codeload.github.com/winguse/miwifi_3_ss/zip/master -o ss.zip
unzip ss.zip
rm ss.zip
cd miwifi_3_ss-master
chmod +x *.sh
./install.sh
```

## Further Automation Tips

As you are using the dev version of the framework, each upgrade of the framework will fuck up your installation. So you may try the following script for automation: 

```shell
#!/usr/bin/expect -f

spawn ssh root@192.168.31.1
match_max 100000

expect "*?assword:*"
send -- "YOUR_ROUTER_PASSWORD\r"
send -- "\r"

expect "root@XiaoQiang:~#*"

send -- "cd /data\r"
send -- "curl https://codeload.github.com/winguse/miwifi_3_ss/zip/master -o ss.zip\r"
send -- "rm -r miwifi_3_ss-master\r"
send -- "unzip ss.zip\r"
send -- "rm ss.zip\r"
send -- "cd miwifi_3_ss-master\r"
send -- "chmod +x *.sh\r"
send -- "./install.sh\r"

# Put your server address here
expect "Host:\r"
send -- "123.123.123.123\r"

# Put your server port here
expect "Port:\r"
send -- "54321\r"

# Put your password here
expect "Password:\r"
send -- "YOUR_SS_PASSWORD\r"

# Put your encrypt method here
expect "Encrypt Method:\r"
send -- "aes-128-gcm\r"

interact
```
