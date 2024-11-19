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

| Env. Variable       | Description                                                                                                                            |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| `FORCE_INSTALL`     | Used to force install some application, usage: `FORCE_INSTALL=true ./run-installer.sh`                                                 |
| `PL10K_NERD_FONT`   | Nerd Font family to be installed, default: `Inconsolata`. Find more at [Nerd Font Download](https://www.nerdfonts.com/font-downloads). |
| `PL10K_INSTALL_DIR` | Define power level 10k installation directory, default: `$PWD/../power-level-10k`                                                      |
| `SDKMAN_DIR`        | Define `SDKMAN` installation directory, default: `$PWD/../sdkman`                                                                      |

## Further Reading

1. [General Tips](cheatsheet/TIPS.md): Simple tips.
2. [Recommended Packages](cheatsheet/RECOMMENDED.md): Highly suggested, will make life easier.
3. [Optional Packages](cheatsheet/OPTIONAL.md): Based on necessity, will be installed eventually.
4. [Development Packages](cheatsheet/DEVELOPMENT.md): Depends on current jobs ;).
5. `apt-fast`: to allow faster package download, default `apt` or `apt-get` was slow enough. ([APT-FAST.md](APT-FAST.md))
6. Third party repository: Add 3rd party repository in a correct way, a guide for deprecated `apt-key` ([REPOSITORY.md](REPOSITORY.md))

