# README for 3rd party repository / PPA

I prefer linux nowadays compared to windows, but I still have some issues such as:

- Outdated software package (default repository tend to have outdated version)
- Your favourite software wasn't provided by default repository
- You want to use proprietary software which isn't open source

Above problems can be solved by adding 3rd party repository or PPA,
this guide will tell you some **DO** and **DON'T**

# Adding 3rd party repository in the correct way

Nowadays most of 3rd party repository guide will use `add-apt-repository` cli,
this approach is safer since it will enforce 3rd party key only for said repository.
If your repository guide was using it therefore just follow thier, this guide for older guide which using `apt-key` instead.
I will take [Insync](https://www.insynchq.com/downloads/linux#apt) as example, their guide still use `apt-key` cli.

## Migrate from `apt-key` to safer approach manually

![Insync using apt-key](images/insync-apt-key.png "Insync using apt-key")

Based on thier guide it will be command should be:

`sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C`

Above command will make Insync key trusted for every repositories, it was a bad practice, we need to download the key manually and store it in "correct" place.

- To obtain the key we will use `keyserver.ubuntu.com` server, open it and search for `0xACCAF35C` (it come from `--recv-keys ACCAF35C` part prefixed with `0x`).
- Once the key was found you will be redirected to `https://keyserver.ubuntu.com/pks/lookup?search=0xACCAF35C&fingerprint=on&op=index`
- We need to download the key, please take a look at `&op=index` part which will show you the key details, just change it into `&op=get` and you will download its key.
  - command: `curl -o insync.asc "https://keyserver.ubuntu.com/pks/lookup?search=0xACCAF35C&fingerprint=on&op=get"`
- Given key was in armored format, refer to `-----BEGIN PGP PUBLIC KEY BLOCK-----` in the beginning, we have to dearmor it first.
- Dearmor by `gpg` CLI
  - command: `gpg --dearmor --output insync.gpg insync.asc`
- Do in one line: `curl "https://keyserver.ubuntu.com/pks/lookup?search=0xACCAF35C&fingerprint=on&op=get" | gpg --dearmor --output insync.gpg`

Technically speaking you can put the dearmored gpg key anywhere in your system directory, but it's recommended to put those keys inside same folder.
`apt-add-reposiory` will store gpg key under `/etx/apt/keyrings/` folder, we should follow the lead.

## Write correct apt `source.list` with proper key

![Insync source.list.d](images/insync-apt-key.png "Insync source.list.d")

Once gpg key successfully extracted we have to add the repository to `apt.source.d`. For the content should follow Insync guide with additional configuration. (TL;DR we need to add `signed-by=...` attribute)

```sh
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/insync-virginia.gpg] http://apt.insync.io/mint virginia non-free contrib" | sudo tee /etc/apt/sources.list.d/insync.list
```

Additionally we can add `arch=amd64` before `signed-by=...` attribute.
