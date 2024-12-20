# OPTIONAL packages

Contains all optional packages, just install when needed.

**WARNING:** You should run these cheat sheet in root of this repository, otherwise it may fail.

# `flameshot` a screenshot utility

Reference:
- [flameshot installation](https://github.com/flameshot-org/flameshot?tab=readme-ov-file#installation)
- [`.deb` provided](../REPOSITORY.md#deb-installation-provided)

**IMPORTANT**:
1. Please ensure your distribution have latest version, some distribution still use older version.
2. Don't forget to override default printscreen packages ([reference](https://github.com/flameshot-org/flameshot?tab=readme-ov-file#on-ubuntu-tested-on-1804-2004-2204)).

## Distribution with latest version

```sh
sudo apt-get update
sudo apt-get install flameshot
```

## Install latest version from GitHub

1. Download latest `.deb` from [here](https://github.com/flameshot-org/flameshot/releases).
2. Install it.

# `deadbeef` minimalist music player

Reference:
- [DeaDBeeF download](https://deadbeef.sourceforge.io/download.html). (Please use download instead of linux distribution package)
- [Software binary already built](../REPOSITORY.md#software-binary-already-built)

1. Open [download page](https://deadbeef.sourceforge.io/download.html) and at `Stable builds` section choose `GNU/Linux`.
2. Extract the archive to dedicated folder on non system partition.
3. Create menu, done.

# `virtualbox` Virtualization engine

Reference:
- [VirtualBox download page](https://www.virtualbox.org/wiki/Linux_Downloads).

## `.deb` package

Dowload it from above page

## Using repository

Guide based on download page, please change `[codename]` with your [Ubuntu codename](https://wiki.ubuntu.com/Releases).

**IMPORTANT:** please refer to latest virtual box version in the download page before installing.

```sh
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor --output /etc/apt/keyrings/oracle-virtualbox.gpg
echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/oracle-virtualbox.gpg] https://download.virtualbox.org/virtualbox/debian [codename] contrib' | sudo tee /etc/apt/sources.list.d/oracle-virtualbox.list
sudo apt-get update
sudo apt-get install virtualbox-7.1
```

# `doublecmd` GUI dual pane file manager

Reference:
- [Double Commander download page](https://sourceforge.net/p/doublecmd/wiki/Download/)
- [Double Commander DEB repositories](https://software.opensuse.org/download.html?project=home%3AAlexx2000&package=doublecmd-gtk)

**IMPORTANT:**
- `doublecmd` have 3 GUI flavours: `gtk`, `qt5`, and `qt6`. This guide will use `gtk` variant, refer to official download page for other variant repositories.
- `[codename]` placeholder please refer to [official guide](https://software.opensuse.org/download.html?project=home%3AAlexx2000&package=doublecmd-gtk). Please drill down `Ubuntu` and find your ubuntu version there. They will use `xUbuntu_XX.YY` instead of [Ubuntu codename](https://wiki.ubuntu.com/Releases).

```sh
curl -fsSL https://download.opensuse.org/repositories/home:Alexx2000/[codename]/Release.key | sudo gpg --dearmor --output /etc/apt/keyrings/double-commander.gpg
echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/double-commander.gpg] http://download.opensuse.org/repositories/home:/Alexx2000/[codename]/ /' | sudo tee /etc/apt/sources.list.d/double-commander.list
sudo apt-get update
sudo apt-get install doublecmd-gtk
```

**TIPS:**
- Once installation done, you can change your "Default Application" or "Preferred Application" to `doublecmd` to override `Super + E` / `Winkey + E` shortcut.
- Open menu `Configuration` > `Options...` then search for `splash` and disable `Splash Screen`, enjoy. 

# `mc` TUI dual pane file manager

```sh
sudo apt-get update
sudo apt-get install mc
```

**TIPS:**
- Bottom bar key accelerator is `Alt` key, therefore `9 Menu` should be invoked as `Alt + 9` of `F9`.
- Accelerator with `M-` prefix means `Ctrl +`, therefore `M-x, o` should be invoked as `Ctrl + x, o`.

# `dnscrypt-proxy` DNS over HTTPS client, skip your goverment cencorship

Reference:
- [DNS Cryprt Github Page](https://github.com/DNSCrypt/dnscrypt-proxy/wiki/Installation-on-Debian-and-Ubuntu#ubuntu).

```sh
sudo apt-get -y install dnscrypt-proxy
```

**TIPS:**
- Once installed, please check `/lib/systemd/system/dnscrypt-proxy.socket` file to determine where is our DNS Cryprt listening.


# `adb` Android Debug Bridge

Reference:
- [Android Developer Page](https://developer.android.com/tools/adb).
- [ADB Download Page](https://developer.android.com/studio/releases/platform-tools).

Fortunately `adb` can be run without any installation, just download it and extract to your favorite folder.
We can skip add `adb` to `PATH` env variable since it rarely used.

Download latest version: [here](https://dl.google.com/android/repository/platform-tools-latest-linux.zip).

# `dconf-editor` Edit Gnome System Variables

```sh
sudo apt-get -y install dconf-editor
```

**TIPS:**
- For battery settings: `/org/cinnamon/settings-daemon/plugins/power/`

# `mkvtoolnix-gui`, `mkvtoolnix`, `mkvmerge` your `.mkv` tools

Reference:
- [MKVToolNix Download Page](https://mkvtoolnix.download/downloads.html#ubuntu).

```sh
curl -fsSL https://mkvtoolnix.download/gpg-pub-moritzbunkus.gpg | sudo gpg --dearmor --output /etc/apt/keyrings/mkvtoolnix-gui.gpg
echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/mkvtoolnix-gui.gpg] https://mkvtoolnix.download/ubuntu/ $(lsb_release -c -s) main' | sudo tee /etc/apt/sources.list.d/mkvtoolnix-gui.list
sudo apt-get update
sudo apt-get install mkvtoolnix mkvtoolnix-gui
```

TIPS:
- `mkvmerge` is part of `mkvtoolnix` package.

# `anydesk` Remote any computer with ease, similar to TeamViewer

Reference:
- [AnyDesk Download Page](https://anydesk.com/en-gb/downloads/linux).
- [AnyDesk Repository Page](http://deb.anydesk.com/howto.html).

```sh
curl -fsSL https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo gpg --dearmor --output /etc/apt/keyrings/anydesk.gpg
echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/anydesk.gpg] ttp://deb.anydesk.com/ all main' | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
sudo apt-get update
sudo apt-get install anydesk
```

