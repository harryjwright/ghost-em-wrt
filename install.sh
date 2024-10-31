# config.txt can be appended with echo
echo "disable_splash=1" >> /boot/config.txt # disable rainbow splash screen
echo "lcd_rotate=2" >> /boot/config.txt # rotate screen 180 deg

# cmdline.txt needs to pass the no-newline argument
echo -n "logo.nologo" >> /boot/cmdline.txt # remove pi logo on tty
echo -n "vt.global_cursor_default=0" >> /boot/cmdline.txt # disable blinking cursor
# echo -n "loglevel=3" >> /boot/cmdline.txt # mute kernel logs (show critical only)

# must login on tty
uci set system.@system[0].ttylogin="1"
uci commit system
service system restart

# update package manager
opkg update

# disable ipv6 https://3os.org/infrastructure/openwrt/disable-ipv6/
uci set 'network.lan.ipv6=0'
uci set 'network.wan.ipv6=0'
uci set 'dhcp.lan.dhcpv6=disabled'
/etc/init.d/odhcpd disable
uci commit
uci -q delete dhcp.lan.dhcpv6
uci -q delete dhcp.lan.ra
uci commit dhcp
/etc/init.d/odhcpd restart
uci set network.lan.delegate="0"
uci commit network
/etc/init.d/network restart
/etc/init.d/odhcpd disable
/etc/init.d/odhcpd stop
uci -q delete network.globals.ula_prefix
uci commit network
/etc/init.d/network restart
