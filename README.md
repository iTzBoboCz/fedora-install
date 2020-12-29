<h1 align="center">Setuprr</h1>
<p align="center">
  <img alt="Logo Banner" src="https://raw.githubusercontent.com/iTzBoboCz/fedora-install/master/logo.svg?sanitize=true"/>
  <br/>
  <br/>
  <a href="https://github.com/iTzBoboCz/fedora-install">
  <img alt="GPL 3.0 License" src="https://img.shields.io/github/license/iTzBoboCz/fedora-install.svg"/>
  </a>
  <a href="https://github.com/iTzBoboCz/fedora-install/releases">
  <img alt="Current Release" src="https://img.shields.io/github/release/iTzBoboCz/fedora-install.svg"/>
  </a>
</p>

Linux setup script to get you running fast.

All you have to do is run

```sh
# get
$ https://github.com/iTzBoboCz/fedora-install/archive/main.zip

# this one-liner probably doesnt work as it has many sub-scripts
foo@bar:~$ bash <(curl -s https://raw.githubusercontent.com/iTzBoboCz/fedora-install/main/install.sh)
```

### If you:
- 💡 have any ideas that this project could benefit from
- ❌ came across any bugs or issues

please contect me through GitHub Issues!
## Arguments

There are additions, like if you have an AMD gpu and want to use the much better mesa-aco to render things you need to run steamlike this in a terminal/override then flatpak env:

``` bash
FLATPAK_GL_DRIVERS=mesa-aco flatpak run com.valvesoftware.Steam
```

Or making it permanent for amd so you only need to click the icon:
``` bash
flatpak override --env=FLATPAK_GL_DRIVERS=mesa-aco --user
```

Same goes for allowing access to external harddrives/controllers for it
``` bash
# Allow talking to controllers
flatpak override --user --device=all com.valvesoftware.Steam
# Allow access to /put-your-own-path-here
flatpak override --filesystem=/put-your-own-path-here com.valvesoftware.Steam
```

Or setting a powersave profile for tuned:
``` bash
sudo tuned-adm profile powersave
```

Linux is a journey, this is only the beginning. There's always more to learn if you want to!


## RUN THIS AS YOUR USER!

Seriously, this changes usersettings. root for the entire script will NOT work.
It may require you due to the time it takes to enter your password multiple times.

## For a free, open source only install run it using

``` bash
#installs wget, gets the script, makes it executable and runs it
sudo dnf install -y wget && wget "https://git.furworks.de/tobias/fedora-install/raw/branch/master/install.sh" -O ./install.sh && chmod +x ./install.sh && ./install.sh
```

## To also get nonfree extensions, like rpmfusion nonfree upstream or steam flatpak run it this way instead

``` bash
#installs wget, gets the script, makes it executable and runs it with steam and nonfree repos added for things like nvidia drivers
sudo dnf install -y wget && wget "https://git.furworks.de/tobias/fedora-install/raw/branch/master/install.sh" -O ./install.sh && chmod +x ./install.sh && ./install.sh --nonfree --steam
```
