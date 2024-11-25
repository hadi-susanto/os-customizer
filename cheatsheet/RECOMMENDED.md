# RECOMMENDED packages

Contains all recommended 3rd party repositories and their packages. Installing this packages will improve daily tasks.

**WARNING:** You should run these cheat sheet in root of this repository, otherwise it may fail.

# `apt-fast` a wrapper for `apt-get`

```sh
sudo add-apt-repository ppa:apt-fast/stable
sudo apt-get update
sudo apt-get install apt-fast
```

# `zsh` a `bash` replacement

References:
- [Installing zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)
- [zsh auto complete select](https://unix.stackexchange.com/questions/267551/how-can-i-configure-zsh-completion-to-launch-a-menu-for-command-options)

```sh
sudo apt-get install zsh
chsh -s $(which zsh)
```

Please relogin after applying `chsh` since changing `shell` need relogin. Once relogin please trigger your terminal app.

## powerlevel10k zsh theme

This theme is require [Nerd Font](https://www.nerdfonts.com/) to work at the fullest, after some consideration I opted to `Inconsolata Nerd Font`.
This repository contains a copy of it for easier installation, but you can find font latest version at: [here](https://www.nerdfonts.com/font-downloads).

```sh
unzip resources/Inconsolata.zip -d inconsolata
sudo mkdir /usr/share/fonts/truetype/inconsolata
sudo cp -v ./inconsolata/*.ttf /usr/share/fonts/truetype/inconsolata/
fc-cache -f -v
rm -r inconsolata
```

Install awesome [powerlevel10k](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#manual) `zsh` theme. Please `git clone` into dedicated folder instead of `HOME` folder.

```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git [/path/to/powerlevel10k]
cd /path/to/powerlevel10k
echo "source $PWD/powerlevel10k.zsh-theme" >> ~/.zshrc
```

Re-open your `zsh` instance to trigger powerlevel10k wizard. Once done please preprend `stty -ixon` in your `~/.zshrc`,
it will allow you to perform `Ctrl + R` (reverse search) and `Ctrl + S` (forward search). Without `stty -ixon`,
only `Ctrl + R` works ([reference](https://stackoverflow.com/questions/791765/unable-to-forward-search-bash-history-similarly-as-with-ctrl-r)).

## Add our custom scripts:

**WARNING:**
- Run following script from repository root folder! Fail to comply may result failed installation.
- By default `git`, `eza`, and `bat` plugins will be loaded, please configure later after installation done.
- Plugins will be loaded if required command found.

```sh
chmod +x ./zsh/install.sh
./zsh/install.sh
```

## `apt-fast` auto completion

**WARNING:** Execute following script after `zsh` installed, otherwise you may encounter command not found error.
Please read [APT-FAST.md](../APT-FAST.md) for further reading and `zsh` completion. This page only list the package without additional actions.

```sh
sudo cp ./zsh/_apt-fast /usr/share/zsh/functions/Completion/Debian/_apt-fast
sudo chown root:root /usr/share/zsh/functions/Completion/Debian/_apt-fast
source /usr/share/zsh/functions/Completion/Debian/_apt-fast
```

# `eza` a replacement for `ls`

Reference: [install eza on debian or ubuntu](https://github.com/eza-community/eza/blob/main/INSTALL.md#debian-and-ubuntu)

```sh
curl -fsSL https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor --output /etc/apt/keyrings/eza-gierens.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/eza-gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/eza-gierens.list
sudo apt-get update
sudo apt-get install eza
```

# `terminator` terminal emulator with pane split capability

Reference: [install gnome terminator](https://github.com/gnome-terminator/terminator/blob/master/INSTALL.md)

```sh
sudo add-apt-repository ppa:mattrose/terminator
sudo apt-get update
sudo apt-get install terminator
```

# `keepasxc` KeePass compatible client

Reference: [install KeePassXC on Linux](https://keepassxc.org/download/#linux)

```sh
sudo add-apt-repository ppa:phoerious/keepassxc
sudo apt-get update
sudo apt-get install keepassxc
```

# `cryptomator` file level encryption made easy

Reference:
- [cryptomator downloads](https://cryptomator.org/downloads/)
- [crptomator PPA](https://launchpad.net/~sebastian-stenzel/+archive/ubuntu/cryptomator)

```sh
sudo add-apt-repository ppa:sebastian-stenzel/cryptomator
sudo apt-get update
sudo apt-get install cryptomator
```

# `insync` cloud storage client

Reference:
- [insync installation](https://www.insynchq.com/downloads/linux#apt)
- [3rd party repositories](../REPOSITORY.md#adding-3rd-party-repository-in-the-correct-way)

**IMPORTANT:** 
- `[codename]` placeholder refer to [mint codename](https://linuxmint.com/download_all.php).
- This script will utlize `lsb_release -c -s` to automatically retrieve Linux Mint codename.

```sh
curl -fsSL "https://keyserver.ubuntu.com/pks/lookup?search=0xACCAF35C&fingerprint=on&op=get" | sudo gpg --dearmor --output /etc/apt/keyrings/insync.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/insync.gpg] http://apt.insync.io/mint $(lsb_release -c -s) non-free contrib" | sudo tee /etc/apt/sources.list.d/insync.list
sudo apt-get update
sudo apt-get install insync
```

# `bat` a `cat` replacement

Reference:
- [`bat` installation](https://github.com/sharkdp/bat?tab=readme-ov-file#on-ubuntu-using-apt)
- [`.deb` provided](../REPOSITORY.md#deb-installation-provided)

**IMPORTANT**
- Ensure your distribution contains latest version of `bat` package.
- Please use `.deb` package from GitHub in case your distribution didn't include latest one. (Download at: [`bat` GitHub Page](https://github.com/sharkdp/bat))
- Try `batdiff` and `man git` and impress yourself.

# `dnscrypt-proxy` your DNS over HTTPS client

Reference:
- [Install dnscrypt-proxy on Ubuntu](https://github.com/DNSCrypt/dnscrypt-proxy/wiki/Installation-on-Debian-and-Ubuntu).

```sh
sudo apt-get update
sudo apt-get install dnscrypt-proxy
```

**After Installation**

- Please check where `dnscrypt-proxy` listening by execute `cat /lib/systemd/system/dnscrypt-proxy.socket`, look for `ListenStream` and `ListenDatagram` value.
- Open your network configuration and choose `Automatic (DHCP) addresses only`.
- Put DNS sever with value from `.socket` one it should be `127.0.0.1` or `127.0.2.1`.
- Change your `DoH` provider to provide some adblock, therefore your ad-blocking will be system wide.
- Execute `systemctl status dnscrypt-proxy-resolvconf.service`, it said service was `inactive` because of `ConditionFileIsExecutable=/sbin/resolvconf was not met`, then just disable it.

## Change `DoH` provider

Reference:
- [GitHub DNSCrypt and DoH servers](https://github.com/DNSCrypt/dnscrypt-resolvers?tab=readme-ov-file).

You just need to change:
- `server_names` from `cloudflare` to `mullvad-adblock-doh` or any other provider of your choice.
- `sources.url` change `v2` to `v3` since your `dnscrypt-proxy` version is > `2.0.42`.

```sh
sudo cp /etc/dnscrypt-proxy/dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml.original
sudo nano /etc/dnscrypt-proxy/dnscrypt-proxy.toml
sudo systemctl restart dnscrypt-proxy
```

# `dconf-editor` low level system variables editor

Reference:
- [Change Linux Mint Battery Thershold](https://forums.linuxmint.com/viewtopic.php?t=407896).

Tips:
- For battery settings: `/org/cinnamon/settings-daemon/plugins/power/`

```sh
sudo apt-get update
sudo apt-get install dconf-editor
```

# `tlp` Advanced Laptop Battery Management

Reference:
- [`tlp` on LinuxConfig](https://linuxconfig.org/how-to-optimize-laptop-battery-life-with-tlp-on-linux).
- [TLP UI GitHub Page](https://github.com/d4nj1/TLPUI).

```sh
sudo apt-get update
sudo apt-get install tlp tlp-rdw
git clone --depth 1 git@github.com:d4nj1/TLPUI.git tlp-ui
cd tlp-ui
python3 -m tlpui
```

TIPS:
- `TLPUI` isn't required but it will give you easier live.
- Complete guide can be found at `/etc/tlp.conf`.
- Ensure your battery type supported by calling `sudo tlp-stat --battery`.

