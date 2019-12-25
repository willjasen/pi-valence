#!/bin/bash

# Enable IPv4 forwarding
echo '1' | sudo tee /proc/sys/net/ipv4/ip_forward
sudo sed -i '/net.ipv4.ip_forward/s/^#//g' /etc/sysctl.conf

# Enable NAT for the tunnel interface
iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE

# Create symlinks
sudo ln -s $PWD/iptables /etc/network/if-up.d/iptables

# Save iptables rule
sudo chown root:root /etc/network/if-up.d/iptables
sudo chmod 755 /etc/network/if-up.d/iptables
