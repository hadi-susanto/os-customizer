# DEVELOPMENT packages

Contains development packages, used for works only

**WARNING:** You should run these cheat sheet in root of this repository, otherwise it may fail.

# `docker` Container

Reference:
- [Docker Installation on Ubuntu](https://docs.docker.com/engine/install/ubuntu/).
- [Docker Linux Post Install](https://docs.docker.com/engine/install/linux-postinstall/).

```sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --output /etc/apt/keyrings/docker.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(cat /etc/upstream-release/lsb-release | grep DISTRIB_CODENAME | cut -d = -f 2) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## HIGHLY RECOMMENDED move your `/var/lib/docker` folder
Move your docker `/var/lib` into another directory, docker images and container will TAKE A LOT OF SPACES.
Reference:
- [Move Docker Data to Another Location](https://mrkandreev.name/snippets/how_to_move_docker_data_to_another_location/).
- [Docker daemon configuration overview](https://docs.docker.com/engine/daemon/).
- [`dockerd` options](https://docs.docker.com/reference/cli/dockerd/#daemon).

```sh
sudo systemctl stop docker
rsync -avP /var/lib/docker/ /path/to/new/docker/location
sudo nano /etc/docker/daemon.json
sudo systemctl start docker
sudo groupadd docker
sudo usermod -aG docker $USER
```

`/etc/docker/daemon.json` content

```json
{
  "data-root": "/path/to/new/docker/location"
}
```

# `dbeaver` DBeaver Community

Reference: [DBeaver Download Page](https://dbeaver.io/download/).

Just download `.deb` from it and install it.

# `microsoft-edge-stable` just another Chromium based browser with vertical tab

Reference:
- [Microsoft Edge Official](https://www.microsoft.com/en-us/edge/).
- [OMG Ubuntu Guide](https://www.omgubuntu.co.uk/2021/01/how-to-install-edge-on-ubuntu-linux).
- [Geeks fo Geeks Guid](https://www.geeksforgeeks.org/how-to-install-microsoft-edge-on-linux/#method-2-installation-of-microsoft-edge-using-the-command-line).

**IMPORTANT**
- Edge will add some cron job, this cron job will perform automatic update and revert `signed-by` attribute. We **SHOULD** disable it's cron job each time we update edge.

## Using `.deb`

Just download it from official download page above.

## Using repository

```sh
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor --output /etc/apt/keyrings/microsoft.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge.list
sudo apt-get update
sudo apt-get install microsoft-edge-stable
sudo chmod -x /etc/cron.daily/microsoft-edge
ll /opt/microsoft/msedge/cron
```

# `sdk` SDKMAN (Manage Java Development Kit)

Reference:
- [SDKMAN Page](https://sdkman.io/install/).

```sh
export SDKMAN_DIR="/usr/local/sdkman"
curl -s "https://get.sdkman.io" | bash
```

# `mvn` Apache Maven

Reference:
- [Apache Maven Download Page](https://maven.apache.org/download.cgi).

```sh
wget -nv --show-progress -i [apache-maven-download-link]
unzip [your-downloaded-file.zip]
```

**TIPS**:
- Please change apache maven cache directory, it will take lots of space.
It can be done by editing `[apache-maven-dir]/conf/settings.xml` and provide value for `<localRepository>`.

