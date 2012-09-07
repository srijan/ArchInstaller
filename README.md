ArchInstaller
=============

Automated installer for Archlinux.

#### Warning:

This script deletes all existing partitions in /dev/sda.


## Usage:

* Boot into arch installation environment (using CD or usb).
* Setup networking.
* Fetch this folder.
* Optionally, put packages already available (for example, on another computer in the LAN) into the folder: files/var/cache/pacman/pkg/
* Also add any other files required for the new system into files folder.
* Open the two scripts install.sh and inside.sh, and edit the variables to your liking.
* Run install.sh
