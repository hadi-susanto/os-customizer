# General Tips and Tricks

This section will have global tips, it may related to OS configuration or may some software configuration.

## Disable plymouth splash screen (boot splash screen)

Disabling boot splash screen will lead to more verbose start up logging. It may render some input in the console,
but worth it since we able to see any error quickly. Reference: [Linux Mint Forum](https://forums.linuxmint.com/viewtopic.php?p=758816#p758816).

1. Edit `GRUB` default by issuing `sudo nano /etc/default/grub`.
2. Change `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"` to `GRUB_CMDLINE_LINUX_DEFAULT="quiet"`. You may remove `quiet` parameter to have more logs.
3. Save it and trigger `GRUB` update by `sudo update-grub`.
