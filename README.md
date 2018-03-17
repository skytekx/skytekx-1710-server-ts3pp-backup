# [](#header-1)SkyTekx server with plugins
SkyTekx is a combination of Tekkit, Hexxit and SkyFactory2.5 in Minecraft 1.7.10.


## [](#header-2)Installation
there are a lot of ways to install this server on any system that is able to run java, but in this guide I will exclusively focus on installing it on debian 8.

Furthermore, my setup works **without screen**.

For server managing we will use rcon and ufw as a firewall.


### [](#header-3)Step 1:

First of all we need to make some preparations in the os to guarantee a reliable system:
Setting up the correct locals:

```bash
cp /usr/share/zoneinfo/UTC /etc/localtime
```
```bash
export LC_ALL=
```
```bash
export LANG=en_US.UTF-8
```
```bash
echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
```
```bash
apt-get update
```
```bash
apt-get dist-upgrade -y
```
```bash
apt-get install -t jessie-backports openjdk-8-jre-headless ca-certificates-java build-essential git ufw -y
```


### [](#header-3)Step 2:

After the preparations are finished we can finally start to set up our service by creating its home.
In order to do that we need to create a system user with the name minecraft as well as the group minecraft.

```bash
adduser minecraft --system --group --home /opt/minecraft-server --disabled-login
```
For security reasons we will create the minecraft server in /opt.
```bash
mkdir -p /opt/minecraft/{backup/server,build/mcrcon,server}
```


### [](#header-3)Step 3:
In order to be able to manage the SkyTekx-server in the future we need to compile mcrcon.

```bash
cd /opt/minecraft-server/build/mcrcon
```
```bash
git clone git://git.code.sf.net/p/mcrcon/code
```
```bash
cd code
```
```bash
gcc mcrcon.c -o mcrcon
```
```bash
mv mcrcon /usr/local/bin/
```


### [](#header-3)Step 4:
Next step we have to clone my skytekx-server repo and link the systemd unit.

```bash
git clone https://github.com/Yuuuux/SkyTekx-Server.git /opt/minecraft-server/server/skytekx-server
```
```bash
chown -Rv minecraft:minecraft /opt/minecraft-server/
```
```bash
ln /opt/minecraft-server/server/skytekx-server/systemd/skytekx.service /etc/systemd/system/
```
```bash
systemctl daemon-reload
```
```bash
systemctl start skytekx.service
```
```bash
systemctl status skytekx.service
```
```bash
systemctl enable skytekx.service
```


### [](#header-3)Step 5:
Last but not least, we should set up a firewall to prevent randoms from loging into mcrcon.

```bash
sed -i 's/IPV6=yes/IPV6=no/g' /etc/default/ufw
```
```bash
ufw allow 21/tcp
```
```bash
ufw allow 25565/tcp
```
```bash
ufw enable
```
