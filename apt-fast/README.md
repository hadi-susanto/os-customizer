# README for `apt-fast`

> This guide created based on official `apt-fast` guide, full guide can be read [github.com/ilikenwf/apt-fast](https://github.com/ilikenwf/apt-fast/)

`apt-fast` used as wrapper of your package manager, supported package manager: `apt`, `apt-get`, `aptitude`.
The wrapper will perform simultaneous download then move them into your package manager cache and lastly trigger your package manager.

# Installation

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

# Next To-Do

## Upgrade your system packages to latest version

```sh
sudo apt-get update
sudo apt-fast upgrade
```

**Note**: to update package dependencies we still use `apt-get`, for upgrade / install we can use `apt-fast`. 

## Install `zsh` completion

In case you haven't install `zsh` please looking for `zsh` guide in this repository.

1. Download `completions/zsh/_apt-fast` from [original source](https://github.com/ilikenwf/apt-fast/blob/master/completions/zsh/_apt-fast) and save locally first.
2. Copy downloaded file to `/usr/share/zsh/functions/Completion/Debian/` folder. `sudo` is required.
3. Change owner of the file `sudo chown root:root /usr/share/zsh/functions/Completion/Debian/_apt-fast`
4. [OPTIONAL] Execute `source /usr/share/zsh/functions/Completion/Debian/_apt-fast` in current terminal to force load, new terminal will automatically loading it.

### TL;DR

Assuming this repository cloned in local computer, we can use following scripts 

```sh
sudo cp ./zsh/_apt-fast /usr/share/zsh/functions/Completion/Debian/_apt-fast
sudo chown root:root /usr/share/zsh/functions/Completion/Debian/_apt-fast
source /usr/share/zsh/functions/Completion/Debian/_apt-fast
```

## [RECOMMENDED] Change default `apt` cache location

`apt-fast` is wrapper around `apt` and `apt-get`, once packages downloaded it will copy those files into `apt` cache and trigger `apt` command.
It's a good idea to move `apt` cache from system directory to other non system partition (because of limited space).

Reference taken from [unix stack-exchange](https://unix.stackexchange.com/questions/160196/change-location-of-the-lists-and-archives-folders) and
I will use `apt.conf.d` approach instead of symlink (native change is better `ln` is last resort).

```sh
sudo nano /etc/apt/apt.conf.d/99-os-customization
```

Write `dir::cache::archives /path/to/new/directory;` into `99-os-customization` and save it.
Don't forget to update `apt-fast` config `APTCACHE` value to `/path/to/new/directory`.

### Encounter Warning Message

In case you get "error" similar to `Download is performed unsandboxed as root as file` please **don't** panic.
It wasn't error, just a warning message (notice `W:` in the beginning) indicate some incorrect permissions.
Package installation / upgrade / others is success. It happen because of permission issues, to fix:

```sh
sudo chown -Rv _apt:root /path/to/new/directory/partial/
sudo chmod -Rv 700 /path/to/new/directory/partial/
```

References:
- [https://askubuntu.com/questions/908800/what-does-this-apt-error-message-download-is-performed-unsandboxed-as-root](https://askubuntu.com/questions/908800/what-does-this-apt-error-message-download-is-performed-unsandboxed-as-root)
- [https://askubuntu.com/questions/1403337/download-is-performed-unsandboxed-as-root-as-file](https://askubuntu.com/questions/1403337/download-is-performed-unsandboxed-as-root-as-file)
- [https://linuxconfig.org/understanding-the-download-is-performed-unsandboxed-as-root-apt-error-in-ubuntu](https://linuxconfig.org/understanding-the-download-is-performed-unsandboxed-as-root-apt-error-in-ubuntu)
