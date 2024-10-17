# `apt-fast` README

> This guide created based on official `apt-fast` guide, full guide can be read [github.com/ilikenwf/apt-fast](https://github.com/ilikenwf/apt-fast/)


## Installation

```sh
sudo add-apt-repository ppa:apt-fast/stable
sudo apt-get update
sudo apt-get -y install apt-fast
```

## Configurations

- [Linux Mint](https://www.linuxmint.com/) should use `apt-get` don't choose `apt` when you configure `apt-fast`.
- Other settings in wizard step can use default value.
- Adjust downloads cache to other directory beside default one (`/var/cache/apt/apt-fast`) since our `/` partition is limited by design.
  - Edit `apt-fast` configuration `sudo nano /etc/apt-fast.conf`
  - Look for `DLDIR` key and change to `DLDIR=/mnt/path/new-cache/apt-fast-download`
  - Do **NOT** update `APTCACHE` yet!

## Next To-Do

### Upgrade your system packages to latest version

```sh
sudo apt-get update
sudo apt-fast upgrade
```

### Install `zsh` completion

In case you haven't install `zsh` please looking for `zsh` guide in this repository.

1. Download `completions/zsh/_apt-fast` from [original source](https://github.com/ilikenwf/apt-fast/blob/master/completions/zsh/_apt-fast) and save locally first.
2. Copy downloaded file to `/usr/share/zsh/functions/Completion/Debian/` folder. `sudo` is required.
3. Change owner of the file `sudo chown root:root /usr/share/zsh/functions/Completion/Debian/_apt-fast`
4. [OPTIONAL] Execute `source /usr/share/zsh/functions/Completion/Debian/_apt-fast` in current terminal to force load, new terminal will automatically loading it.

### [RECOMMENDED] Change default `apt` cache location

`apt-fast` is wrapper around `apt` and `apt-get`, once packages downloaded it will copy those files into `apt` cache and trigger `apt` command.
It's a good idea to move `apt` cache from system directory to other non system partition (because of limited space).

Reference taken from [unix stack-exchange](https://unix.stackexchange.com/questions/160196/change-location-of-the-lists-and-archives-folders) and
I will use `apt.conf.d` approach instead of symlink (native change is better `ln` is last resort).

```sh
sudo nano /etc/apt/apt.conf.d/99-os-customization
```

Write `dir::cache::archives /path/to/new/directory;` into `99-os-customization` and save it.
Don't forget to update `apt-fast` config `APTCACHE` value to `/path/to/new/directory`.

