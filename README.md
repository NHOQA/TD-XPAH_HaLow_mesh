OS is raspbian 64 bit bookworm lite

Install kernel headers with 'sudo apt install -y raspberrypi-kernel raspberrypi-kernel-headers'
Install drivers per teledatics documentation at https://teledatics.com/docs/drivers/
place br0.netdev, br0.network,and eth0.network in /etc/systemd/network (edit br0.network with IP address you want)
place fullmesh2.sh in home directory (~), edit IP address/mesh name and make executable 'sudo chmod +x fullmesh2.sh'
place fullmesh2.service in etc/systemd/system. Edit correct user name into path to fullmesh2.sh
Set permissions with 'sudo chmod 744 ~/fullmesh2.sh' and 'sudo chmod 644 /etc/systemd/system/fullmesh2.service'
Restart systemd 'sudo systemctl daemon-reload'
Enable service "sudo systemctl enable fullmesh2.service"
Pi will no longer run wlan0, will need to be accessed via ethernet at the static IP assigned previously

Images

pimesh2: natak@raspberrypi1, 192.168.200.1/24, no auto start and no security
https://drive.google.com/file/d/1TfkgTjPlrcTT_izbBDS0qz1eo8AT1QMr/view?usp=drive_link