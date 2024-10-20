# RECOMMENDED packages

Contains all recommended 3rd party repositories and their packages. Installing this packages will improve daily tasks.

**WARNING:** You should run these cheat sheet in root of this repository, otherwise it may fail.

# `apt-fast` a wrapper for `apt-get`

Please read [`apt-fast` README.md](../apt-fast/README.md)

# `zsh` a `bash` replacement

```sh
sudo apt-get install zsh
chsh -s $(which zsh)
```

Once done, reopen your terminal app and configure `zsh` for the first time.

References:
- [Installing zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)
- [zsh auto complete select](https://unix.stackexchange.com/questions/267551/how-can-i-configure-zsh-completion-to-launch-a-menu-for-command-options)

## `zsh` extensions

### Add our custom scripts:

**WARNING**: It may require some other packages to be installed such as `eza`.
Please check latest `zsh/custom.zsh-theme` for details.

```sh
echo "source $PWD/zsh/custom.zsh-theme" >> ~/.zshrc
```

### powerlevel10k zsh theme

This theme is require [Nerd Font](https://www.nerdfonts.com/) to work at the fullest, after some consideration I opted to `Inconsolata Nerd Font`.
This repository contains a copy of it for easier installation, but you can find font latest version at: [here](https://www.nerdfonts.com/font-downloads).

```sh
unzip resources/Inconsolata.zip -d inconsolata
sudo mkdir /usr/share/fonts/truetype/inconsolata
sudo cp -v ./incosolata/*.ttf /usr/share/fonts/truetype/inconsolata/
fc-cache -f -v
rm -r inconsolata
```

Install awesome [powerlevel10k](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#manual) `zsh` theme. Please `git clone` into dedicated folder instead of `HOME` folder.

```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git [/path/to/powerlevel10k]
echo "source $PWD/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
```

Re-open your `zsh` instance to trigger powerlevel10k wizard. Once done please preprend `stty -ixon` in your `~/.zshrc`,
it will allow you to perform `Ctrl + R` (reverse search) and `Ctrl + S` (forward search). Without `stty -ixon`,
only `Ctrl + R` works ([reference](https://stackoverflow.com/questions/791765/unable-to-forward-search-bash-history-similarly-as-with-ctrl-r)).

# `eza` a replacement for `ls`

Reference: [install eza on debian or ubuntu](https://github.com/eza-community/eza/blob/main/INSTALL.md#debian-and-ubuntu)

```sh
curl https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor --output /etc/apt/keyrings/eza-gierens.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/eza-gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/eza-gierens.list
sudo apt-get update
sudo apt-get install eza
```

**INFORMATION**: [`zsh/custom.zsh-theme`](zsh/custom.zsh-theme) contains aliases for `eza` override `ls` and `ll`.

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
- [3rd party repositories](../repositories/README.md#adding-3rd-party-repository-in-the-correct-way)

**IMPORTANT:** for `[codename]` placeholder please refer to [mint codename](https://linuxmint.com/download_all.php).

```sh
curl "https://keyserver.ubuntu.com/pks/lookup?search=0xACCAF35C&fingerprint=on&op=get" | sudo gpg --dearmor --output /etc/apt/keyrings/insync.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/insync.gpg] http://apt.insync.io/mint [codename] non-free contrib" | sudo tee /etc/apt/sources.list.d/insync.list
sudo apt-get update
sudo apt-get install insync
```

# `bat` a `cat` replacement

Reference:
- [`bat` installation](https://github.com/sharkdp/bat?tab=readme-ov-file#on-ubuntu-using-apt)
- [`.deb` provided](repositories/README.md#deb-installation-provided)

**IMPORTANT**
- Ensure your distribution contains latest version of `bat` package.
- Please use `.deb` package from GitHub in case your distribution didn't include latest one.
- Try `batdiff` and `man git` and impress yourself.
