#!/bin/bash
#this is the mesh and bridge scripts combined. successfully tested individually
#before running script, you will need
#1. br0.network, br0.netdev, eth0.network placed in etc/systemd/network
#2. 
#3. TD_XPAH drivers installed per https://teledatics.com/docs/drivers/

#stop some processes that interfere with what we're trying to do
systemctl stop wpa_supplicant
systemctl stop NetworkManager
systemctl enable systemd-networkd

#set variables these will need to be adjusted to match your system/desired mesh settings
INTERFACE=wlan1 #this is the XPAH interface. need to have drivers for it installed before running this
MESH_NAME=natak_mesh #adjust to whatever you want, all nodes need exact same name
ETH=eth0 #ethernet interface, adjust to match your ethernet interface name
IP_ADDR=192.168.200.1/24 #adjust to whatever you want, unique address for each node. with this format># x, 192.168.200.x/24

ifconfig $INTERFACE down
#sysctl lines not needed if bridging interface
#sysctl -w net.ipv4.ip_forward=1
#sysctl -p
iw reg set "US"
iw dev $INTERFACE set type managed
iw dev $INTERFACE set 4addr on
iw dev $INTERFACE set type mesh
iw dev $INTERFACE set meshid $MESH_NAME
iw dev $INTERFACE set channel 36 #original channel setting from teledatics 908.5 MHZ w/ 1 MHz bandwidth<br>
ip addr add $IP_ADDR dev $INTERFACE
ifconfig $INTERFACE up

#bridge created, IP address assigned and eth0 slaved by systemd files

#bring bridge up
ip link set dev br0 up

#add mesh connection to bridge
ip link set $INTERFACE master br0


#delete ip from mesh node to avoid conflict
sudo ip address del $IP_ADDR dev $INTERFACE
sudo systemctl restart systemd-networkd
