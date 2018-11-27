#!/bin/bash
# 
# remove the tty1.service 
rm -f /etc/systemd/system/getty.target.wants/getty@tty1.service
#
#
# add the new tty1.service
cp /lib/systemd/system/getty@.service /etc/systemd/system/getty@tty1.service
#
# eanble autologin for root user
sed  -i 's#^ExecStart=.*#ExecStart=-/sbin/agetty --autologin root --noclear %I#' /etc/systemd/system/getty@tty1.service
#
# update teh autologin tty parameter 
sed -i  '/DefaultInstance=tty1/a\;Alias=getty@tty1.service' /etc/systemd/system/getty@tty1.service
#
# 
ln -s /etc/systemd/system/getty@tty1.service /etc/systemd/system/getty.target.wants/getty@tty1.service
#
#
