#!/bin/bash
source /usr/local/lib/color_output
myred "Restore the default settings for xCAT tables "
cd  /opt/xcat/share/xcat/templates/e1350/
for a in *csv
do
tabrestore $a
myyellow "$a Table restore done"
done
myred "Start to config the Site Table"
chdef -t site clustersite master=172.20.0.1
chdef -t site clustersite nameservers=172.20.0.1
chdef -t site clustersite domain=cluster
chdef -t site clustersite dhcpinterfaces=ens8
#
#
myred "Start to config the Networks Table"
chdef -t network 172_20_0_0-255_255_0_0 dynamicrange=172.20.255.1-172.20.255.254
#
#
myred "Start to config the Node Hardware Management  Table"
chtab node=compute nodehm.serialport=0 nodehm.serialspeed=115200 nodehm.serialflow=hard
chtab node=smm nodehm.mgt=ipmi
#
#
myred "Start to config the Node type  Table"
chtab node=compute nodetype.os=rhels7.5 nodetype.arch=x86_64 nodetype.Profile=compute
#
#
myred "Start to config the Node Resource  Table"
chtab node=compute noderes.netboot=xnba noderes.installnic=mac noderes.primarynic=mac
#
#
myred "Start to config the Switch  Table"
nodeadd switch1 groups=switch
nodech switch switches.password="RO"
