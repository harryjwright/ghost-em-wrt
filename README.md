# Ghost 'em WRT

## Requirements
- Computer with ethernet port
- Micro SD card and flashing apparatus
- Ethernet cable
- Raspberry Pi with wifi radio
- Raspberry Pi screen for log-to-TTY
- VPN subscription with OpenVPN support

# Installation
- Go to [OpenWRT Firmware Selector](https://firmware-selector.openwrt.org) and download the Factory (EXT4) version for your device.
- Flash the image to an SD card ([Balena Etcher](https://etcher.balena.io/) is available for Linux).
- Insert the SD card into the Raspberry Pi and boot.
- **Change the password with the provided command**.
- Now, when connecting your computer via ethernet to the Pi, you should be able to ssh into your router.

  you@your-pc:~ ssh root@192.168.1.1
  
  root@192.168.1.1's password: ENTER_PASSWORD_HERE

- If you plug a keyboard into your Pi, you'll notice you didn't need to log in to the TTY terminal. We can ammend that with:

  you@your-pc:~ uci set system.@system[0].ttylogin="1"
  
  you@your-pc:~uci commit system
  
  you@your-pc:~service system restart

## Luci

  luci-app-adblock
  
  luci-app-banip
  
  luci-app-clamav
  
  luci-app-nlbwmon
  
  luci-app-openvpn

## Common Errors

### nlbwmon

    daemon.err nlbwmon[1532]: Netlink receive failure: Object busy
    daemon.err nlbwmon[1532]: Unable to dump conntrack: I/O error

This error was supposed to be resolved by doubling the memory

### openvpn

    daemon.warn openvpn(YOUR_VPN_NAME)[2517]: WARNING: `link-mtu' is used inconsistently, local=`VALUE', remote=`VALUE'
    daemon.warn openvpn(YOUR_VPN_NAME)[2517]: WARNING: `auth' is used inconsistently, local=`VALUE', remote=`VALUE'
    daemon.warn openvpn(YOUR_VPN_NAME)[2517]: WARNING: `keysize' is used inconsistently, local=`VALUE', remote=`VALUE'

This error is *supposedly* related to the OpenVPN version used in OpenWRT's stable branch. When OpenWRT upgrades to the next main version, this *should* be resolved.
