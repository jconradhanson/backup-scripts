# backup-scripts

Backup scripts for macOS (OSX), Debian-based Linux, and Windows 10 to a local FreeNAS server.

## Find MAC Address of FreeNAS server

Login to the router the server is connected to and inspect the server's connection details. The mac address should be specified somewhere. For example, ASUS routers have a smartphone app that shows all connected devices and their IP and mac addresses.

or

In the server's terminal, run:

    ifconfig | grep WOL

Determine which entry the outputted line belongs to, noting the `ether` entry. This is the mac address of the wake-on-lan enabled network interface.

## SSH Setup for Password-less Login

Create a key pair on the machine you will be using to login to the FreeNas server. Save the key pair into the `~/.ssh/` folder and output the public key.

    ssh-keygen
    more ~/.ssh/example_rsa.pub

Add the public key to the FreeNAS user you want to login as when using SSH.
