# Ghost 'Em WRT 👻

![Ghost 'em WRT Report Image](repo-image.png?raw=true "Repo Image")

## Basic Requirements
- computer with ethernet port
- ethernet cable
- micro SDHC card
- micro SD card flashing capability
- raspberry Pi (model 3, 4 or 5 supported)

## Pro Requirements
- pi screen
- active vpn subscription with OpenVPN support (e.g. [proton-vpn](https://www.protonvpn.com) or [nord-vpn](https://nordvpn.com/)).
- 802.11 usb wifi radio adapter. I recommend one of the devices you will find when looking [here](https://duckduckgo.com/?q=mediatek+rt5370+usb+Wifi+802.11+adapter).

# Raspberry Pi Setup
- go to [OpenWRT Firmware Selector](https://firmware-selector.openwrt.org) and download the Factory (EXT4) version for your device.
- flash the image to an sd card. [Balena Etcher is a good flashing tool](https://etcher.balena.io/).
- insert the sd card into the pi and boot.
- now, when connecting your computer via ethernet to the pi, you should be able to ssh into your router.

      you@your-pc:~ ssh root@192.168.1.1
      root@192.168.1.1's password: ENTER_PASSWORD_HERE

- change the password

      root@OpenWrt:~# passwd

- if you plug a keyboard into your Pi, you'll notice you didn't need to log in to the TTY terminal. We can ammend that with:

      root@OpenWrt:~# uci set system.@system[0].ttylogin="1"
      root@OpenWrt:~# uci commit system
      root@OpenWrt:~# service system restart

- on your laptop navigate to [luci](https://192.168.1.1/cgi-bin/luci/) and log in
- go to the [wireless section](https://192.168.1.1/cgi-bin/luci/admin/network/wireless) and connect to the network you want to intermediary (use a randomised mac and make sure to set your country code)
- update the package manager (opkg)

      root@OpenWrt:~# opkg update

# OpenWRT Configuration

## Screen Rotation

When I use the Official 7" screen inside my designated case, the screen is upside-down. To ammend this

    root@OpenWrt:~# cd /boot
    root@OpenWrt:/boot# vi config.txt

In vi, you can change to insert mode by pressing `i`. In the configuration, adding `lcd_rotate=2` will rotate it two times ninety degrees (180 degrees). Then write and quit (`:wq!`) and reboot (`reboot`).

## Log to Screen

The screen you are looking at if you have connected a screen is the TTY terminal. If you want to display errors and warning on this screen to monitor what's going on behind-the scenes, navigate to `System > System > Logging` and write to the log file `/dev/tty0`.

## Run Bash Script

    git clone https://github.com/harryjwright/ghost-em-wrt/
    cd ghost-em-wrt
    chmod +x install.sh
    ./install.sh

## Additional tools for learning

  luci-app-adblock
  
  luci-app-banip
  
  luci-app-clamav
  
  luci-app-nlbwmon
  
  luci-app-openvpn

## Common Errors

### nlbwmon

**Object busy**

    daemon.err nlbwmon[1532]: Netlink receive failure: Object busy
    daemon.err nlbwmon[1532]: Unable to dump conntrack: I/O error

**Out of memory**

    daemon.err nlbwmon[1533]: Netlink receive failure: Out of memory
    daemon.err nlbwmon[1533]: Unable to dump conntrack: No buffer space available

### openvpn

**Reply warning**

    daemon.err openvpn(YOUR_VPN_NAME)[2515]: AEAD Decrypt error: bad packet ID (may be a replay): [ #17027 ] -- see the man page entry for --no-replay and --replay-window for more info or silence this warning with --mute-replay-warnings
    
**Inconsistence**

    daemon.warn openvpn(YOUR_VPN_NAME)[2517]: WARNING: `link-mtu' is used inconsistently, local=`VALUE', remote=`VALUE'
    daemon.warn openvpn(YOUR_VPN_NAME)[2517]: WARNING: `auth' is used inconsistently, local=`VALUE', remote=`VALUE'
    daemon.warn openvpn(YOUR_VPN_NAME)[2517]: WARNING: `keysize' is used inconsistently, local=`VALUE', remote=`VALUE'

This warning is *supposedly* related to the OpenVPN version used in OpenWRT's stable branch. When OpenWRT upgrades to the next main version, this *should* be resolved. As stated in the log, this is only a warning.

## Tests

[DNS Leak Test](https://www.dnsleaktest.com/)
