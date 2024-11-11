# README

This will contains all the scripts / hacks / configurations after installing "proper OS" (Read: Linux Mint) on my personal workstation.
These guides / cheatsheets are build based on Linux Mint (Ubuntu derivative), therefore it may be can be used for Ubuntu, but cross your fingers.

## Usage

**Clone** this repo to your local PC via `git clone --depth 1 git@github.com:hadi-susanto/os-customizer.git`.
Don't forget to generate your SSH key first by invoking `ssh-keygen` and register your `~/.ssh/id_rsa.public` key to github.

1. [General Tips](cheatsheet/TIPS.md): Simple tips.
2. [Recommended Packages](cheatsheet/RECOMMENDED.md): Highly suggested, will make life easier.
3. [Optional Packages](cheatsheet/OPTIONAL.md): Based on necessity, will be installed eventually.
4. [Development Packages](cheatsheet/DEVELOPMENT.md): Depends on current jobs ;).

## To Read
1. `apt-fast`: to allow faster package download, default `apt` or `apt-get` was slow enough. ([README.md](apt-fast/README.md))
2. Third party repository: Add 3rd party repository in a correct way, a guide for deprecated `apt-key` ([README.md](repositories/README.md))
