#!/bin/bash

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
dnscrypt-proxy_installed() {
  command -v dnscrypt-proxy 2>&1 > /dev/null
}

# Short and meaningful installer description, describing the app being installed.
dnscrypt-proxy_describe() {
  echo "DNS over HTTPS client, skip your goverment cencorship"
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
dnscrypt-proxy_pre_install() {
  sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
dnscrypt-proxy_install() {
  if command -v apt-fast 2>&1 > /dev/null; then
    sudo apt-fast -y install cryptomator
  else
    sudo apt-get -y install cryptomator
  fi
}

# Called after installation completed successfully
# Post installation may contains user interactive session
dnscrypt-proxy_post_install() {
  return 0
}

# Optional function / method
# Called after all installers successfuly installed. Used to inform user action once activity done.
dnscrypt-proxy_post_install_message() {
  cat << EOF
TIPS:
* Please check where dnscrypt-proxy listening by execute cat /lib/systemd/system/dnscrypt-proxy.socket, look for ListenStream and ListenDatagram value.
* Open your network configuration and choose Automatic (DHCP) addresses only.
* Put DNS sever with value from .socket one it should be 127.0.0.1 or 127.0.2.1.
* Change your DoH provider to provide some adblock, therefore your ad-blocking will be system wide.
* Execute systemctl status dnscrypt-proxy-resolvconf.service, it said service was inactive because of ConditionFileIsExecutable=/sbin/resolvconf was not met, then just disable it.

Change DoH Provider to enable AdBlock at DNS level:
* Edit /etc/dnscrypt-proxy/dnscrypt-proxy.toml
* server_names from cloudflare to mullvad-adblock-doh or any other provider of your choice.
* sources.url change v2 to v3 since your dnscrypt-proxy version is > 2.0.42.
EOF
}

