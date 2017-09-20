echo "Start uninstall Shadowsocks"
echo -e "Stoping processes--------------------------------------\c"
/etc/init.d/shadowsocks stop 1>/dev/null 2>&1
/etc/init.d/shadowsocks disable 1>/dev/null 2>&1
/etc/init.d/rngd stop 1>/dev/null 2>&1
/etc/init.d/rngd disable 1>/dev/null 2>&1
echo -e "Removing files--------------------------------------\c"
rm -rf /etc/init.d/shadowsocks
rm -rf /etc/init.d/rngd
rm -rf /etc/dnsmasq.d/dnsmasq_list.conf
rm -rf /etc/shadowsocks.json
find ./usr -type f | awk -F: 'system("rm /data/" $0)'
sed -i '/ipset -N proxylist iphash -!/d' /etc/firewall.user
sed -i '/iptables -t nat -A PREROUTING -p tcp -m set --match-set proxylist dst -j REDIRECT --to-port 1081/d' /etc/firewall.user
/etc/init.d/firewall restart
/etc/init.d/dnsmasq restart
echo "Uninstall Shadowsocks Done"