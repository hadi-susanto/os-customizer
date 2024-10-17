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

Upgrade your system packages to latest version

```sh
sudo apt-get update
sudo apt-fast upgrade
```

