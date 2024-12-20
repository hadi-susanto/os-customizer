# README

This will contains all the scripts / hacks / configurations after installing "proper OS" (Read: Linux Mint) on my personal workstation.
These guides / cheatsheets are build based on Linux Mint (Ubuntu derivative), therefore it may be can be used for Ubuntu, but cross your fingers.

## Usage

```sh
git clone --depth 1 git@github.com:hadi-susanto/os-customizer.git
cd os-customizer
chmod +x run-installer.sh
./run-installer.sh
```

### Environment Variable(s) to Change Installer Behavior(s)

**App Environment Variable**

| Env. Variable              | Description                                                                                                                            |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| `APACHE_MAVEN_INSTALL_DIR` | Define apache maven installation directory, default: `$PWD/../maven`                                                                   |
| `DOCKER_VAR_LIB_DIR`       | Define where `/var/lib/docker` folder moved into, default: `$PWD/../docker-lib`                                                        |
| `FORCE_INSTALL`            | Used to force install some application, usage: `FORCE_INSTALL=true ./run-installer.sh`                                                 |
| `PL10K_NERD_FONT`          | Nerd Font family to be installed, default: `Inconsolata`. Find more at [Nerd Font Download](https://www.nerdfonts.com/font-downloads). |
| `PL10K_INSTALL_DIR`        | Define power level 10k installation directory, default: `$PWD/../power-level-10k`                                                      |
| `SDKMAN_DIR`               | Define `SDKMAN` installation directory, default: `$PWD/../sdkman`                                                                      |
| `TLP_UI_INSTALL_DIR`       | Define `TLPUI` installation directory, default: `$PWD/../tlp-ui`                                                                       |

**ZSH Plugin Environment Variable (Used when install zsh-plugin)**

| Env. Variable                 | Description                                                                                                                         |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `MKVMERGE_DEFAULT_OUTPUT_DIR` | Used to set default value of `MKVMERGE_DEFAULT_OUTPUT_DIR`, this variable used by [`mkvmerge.install.sh`](zsh/mkvmerge.install.sh). |

## Further Reading

1. [General Tips](cheatsheet/TIPS.md): Simple tips.
2. [Recommended Packages](cheatsheet/RECOMMENDED.md): Highly suggested, will make life easier.
3. [Optional Packages](cheatsheet/OPTIONAL.md): Based on necessity, will be installed eventually.
4. [Development Packages](cheatsheet/DEVELOPMENT.md): Depends on current jobs ;).
5. `apt-fast`: to allow faster package download, default `apt` or `apt-get` was slow enough. ([APT-FAST.md](APT-FAST.md))
6. Third party repository: Add 3rd party repository in a correct way, a guide for deprecated `apt-key` ([REPOSITORY.md](REPOSITORY.md))

