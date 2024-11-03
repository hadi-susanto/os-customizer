# OPTIONAL packages

Contains all optional packages, just install when needed.

**WARNING:** You should run these cheat sheet in root of this repository, otherwise it may fail.

# `flameshot` a screenshot utility

Reference:
- [flameshot installation](https://github.com/flameshot-org/flameshot?tab=readme-ov-file#installation)
- [`.deb` provided](repositories/README.md#deb-installation-provided)

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
- [Software binary already built](../repositories/README.md#software-binary-already-built)

1. Open [download page](https://deadbeef.sourceforge.io/download.html) and at `Stable builds` section choose `GNU/Linux`.
2. Extract the archive to dedicated folder on non system partition.
3. Create menu, done.

## `doublecmd` GUI Dual pane file manager (Useful for copy large file)

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

## `mc` Text-Based GUI dual pane file manager (Midnight Commander)

```sh
sudo apt-get update
sudo apt-get install mc
```

**TIPS:**
- Bottom bar key accelerator is `Alt` key, therefore `9 Menu` should be invoked as `Alt + 9` of `F9`.
- Accelerator with `M-` prefix means `Ctrl +`, therefore `M-x, o` should be invoked as `Ctrl + x, o`.
