#!/bin/bash
# 
source /usr/local/lib/color_output
mygreen "setup the Hostname"
hostnamectl set-hostname mgt.cluster
#
mygreen "clear the iptables"
systemctl disable iptables.service
systemctl stop iptables.service
iptables -F
iptabels-save
#
systemctl disable firewalld
systemctl stop firewalld
#
mygreen "Disable the selinux "
sed -i 's#SELINUX=.*#SELINUX=disabled#' /etc/sysconfig/selinux
#
mygreen "Setup the Network for rack communications"
myyellow " nmcli connection add con-name ens8 ifname ens8 type ethernet autoconnect yes ip4 172.20.0.1/16 ip4 172.29.0.1/16 ip4 172.30.0.1/16"

