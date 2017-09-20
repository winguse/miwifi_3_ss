#!/bin/sh

./uninstall.sh

echo "#############################################################"
echo "# Install Shadowsocks for Miwifi(r3)"
echo "#############################################################"

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "Error:This script must be run as root!" 1>&2
   exit 1
fi

# install shadowsocks binaries
mkdir -p /data/usr
cp -rf ./usr/*  /data/usr/
chmod +x /data/usr/bin/*
chmod +x /data/usr/lib/*

# Config shadowsocks init script
cp ./shadowsocks /etc/init.d/shadowsocks
chmod +x /etc/init.d/shadowsocks

# rngd
cp ./rngd /etc/init.d/rngd
chmod +x /etc/init.d/rngd

#config setting and save settings.
echo "#############################################################"
echo "#"
echo "# Please input your shadowsocks configuration"
echo "#"
echo "#############################################################"
echo ""
echo "Host:"
read serverip
echo "Port:"
read serverport
echo "Password:"
read shadowsockspwd
echo "Encrypt Method:"
read method

# Config shadowsocks
cat > /etc/shadowsocks.json<<-EOF
{
  "server":"${serverip}",
  "server_port":${serverport},
  "local_address":"127.0.0.1",
  "local_port":1081,
  "password":"${shadowsockspwd}",
  "timeout":600,
  "method":"${method}"
}
EOF

#config dnsmasq
cp -f ./dnsmasq_list.conf /etc/dnsmasq.d/dnsmasq_list.conf

#config firewall
cp -f /etc/firewall.user /etc/firewall.user.back
echo "ipset -N proxylist iphash -! " >> /etc/firewall.user
echo "iptables -t nat -A PREROUTING -p tcp -m set --match-set proxylist dst -j REDIRECT --to-port 1081" >> /etc/firewall.user

#restart all service
/etc/init.d/dnsmasq restart
/etc/init.d/firewall restart
/etc/init.d/shadowsocks restart
/etc/init.d/shadowsocks enable
/etc/init.d/rngd restart
/etc/init.d/rngd enable

#install successfully
echo ""
echo "Shadowsocks Done!"
echo ""
exit 0
