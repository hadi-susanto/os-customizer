# General Tips and Tricks

This section will have global tips, it may related to OS configuration or may some software configuration.

# Disable plymouth splash screen (boot splash screen)

Disabling boot splash screen will lead to more verbose start up logging. It may render some input in the console,
but worth it since we able to see any error quickly. Reference: [Linux Mint Forum](https://forums.linuxmint.com/viewtopic.php?p=758816#p758816).

1. Edit `GRUB` default by issuing `sudo nano /etc/default/grub`.
2. Change `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"` to `GRUB_CMDLINE_LINUX_DEFAULT="quiet"`. You may remove `quiet` parameter to have more logs.
3. Save it and trigger `GRUB` update by `sudo update-grub`.

# Disable asterisk (`*`) when typing password in terminal

Reference: [Linux Mint Release](https://blog.linuxmint.com/?p=3715#comment-147187).

```sh
sudo mv /etc/sudoers.d/0pwfeedback /etc/sudoers.d/0pwfeedback.disabled
```

**FYI:** Relogin is required, to apply this feature.

# Create Custom Firefox Profile

Open terminal and invoke `firefox -p` to open Firefox's profile manager without running its web browser.
Create a new profile with dedicated profile folder outside default one.
Please don't delete `~/.mozilla` folder, otherwise your profiles may be unlinked.

# Common Keyboard Shortcut

Reference:
- [82 Linux Mint Shortcuts](https://shortcutworld.com/Linux-Mint/linux/Linux-Mint_Shortcuts).

## File Manager (`nemo`)

| Key          | Description                                                      |
|--------------|------------------------------------------------------------------|
| `Ctrl` + `1` | Icon View                                                        |
| `Ctrl` + `2` | List View                                                        |
| `Ctrl` + `3` | Compact View                                                     |
| `Ctrl` + `.` | Show/Hide hidden files                                           |
| `F3`         | Show/Hide Extra Pane (vertical split pane)                       |
| `F6`         | Toggle beetween Left/Right pane (require Extra Pane to be shown) |
| `F9`         | Show/Hide Tree View                                              |
