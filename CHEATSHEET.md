# CHEAT SHEET

Contains all recommended 3rd party repositories and their packages. Installing this packages will improve daily tasks.

**WARNING:** You should run these cheat sheet in root of this repository, otherwise it may fail.

# `apt-fast`

Please read [`apt-fast` README.md](apt-fast/README.md)

# `zsh`

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

Install awesome [powerlevel10k](https://github.com/romkatv/powerlevel10k) `zsh` theme. Please `git clone` into dedicated folder instead of `HOME` folder.

```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git [/path/to/powerlevel10k]
echo "source $PWD/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
```

Re-open your `zsh` instance to trigger powerlevel10k wizard.

