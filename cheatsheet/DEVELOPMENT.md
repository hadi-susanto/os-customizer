# DEVELOPMENT packages

Contains development packages, used for works only

**WARNING:** You should run these cheat sheet in root of this repository, otherwise it may fail.

# `microsoft-edge-stable` just another Chromium based browser with vertical tab

Reference:
- [Microsoft Edge Official](https://www.microsoft.com/en-us/edge/).
- [OMG Ubuntu Guide](https://www.omgubuntu.co.uk/2021/01/how-to-install-edge-on-ubuntu-linux).
- [Geeks fo Geeks Guid](https://www.geeksforgeeks.org/how-to-install-microsoft-edge-on-linux/#method-2-installation-of-microsoft-edge-using-the-command-line).

**IMPORTANT**
- Edge will add some cron job, this cron job will perform automatic update and revert `signed-by` attribute. We **SHOULD** disable it's cron job each time we update edge.

## Using `.deb`

Just download it from official download page above.

## Using repositories

```sh
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor --output /etc/apt/keyrings/microsoft.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge.list
sudo apt-get update
sudo apt-get install microsoft-edge-stable
sudo chmod -x /etc/cron.daily/microsoft-edge
ll /opt/microsoft/msedge/cron
```
