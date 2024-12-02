#!/bin/bash

ARCH=$(uname -mosrv)
CPU_PHYSICAL=$(grep 'physical_id' /proc/cpuinfo | uniq | wc -l)
CPU_VIRTUAL=$(grep 'processor' /proc/cpuinfo | uniq | wc -l)
CPU_LOAD=$(top -bn1 | grep '^%Cpu' | awk '{print $2 + $4}')
MEM_USING=$(free -m | grep Mem | awk '{print $3}')
MEM_TOTAL=$(free -m | grep Mem | awk '{print $2}')
MEM_PERCENT=$(free -k | grep Mem | awk '{printf("%.2f"), $3 / $2 * 100}')
DISK_USED=$(df -h --total | grep total | awk '{print $3}')
DISK_TOTAL=$(df -h --total | grep total | awk '{print $4}')
DISK_PERCENT=$(df -h --total | grep total | awk '{print $5}')
LAST_BOOT=$(who -b | awk '{print $3 " " $4}')
LVM_USE=$(if [ $(lsblk | grep lvm | wc -l) -eq 0]; then echo no; else echo yes; fi)
TCP_CONNECTIONS=$(grep TCP /proc/net/sockstat awk '{print $3}')
USER_LOG=$(who | wc -l)
IP=$(hostname -I awk | '{print $1}')
MAC=$(ip link show | grep link/ether | awk '{print $2}')
SUDO_AMOUNT=$(grep COMMAND /var/log/sudo/sudo.log | wc -l)

wall "
      # Architecture    : $ARCH
      # Physical CPUs   : $CPU_PHYSICAL
      # Virtual CPUs    : $CPU_VIRTUAL
      # CPU Load        : $CPU_LOAD
      # Memory Usage    : $MEM_USING/$MEM_TOTAL MB ($MEM_PERCENT)
      # Disk Usage      : $DISK_USED/$DISK_TOTAL ($DISK_PERCENT)
      # Last Boot       : $LAST_BOOT
      # LVM Use         : $LVM_USE
      # TCP Connections : $TCP_CONNECTIONS
      # User Log        : $USER_LOG
      # Network         : $IP ($MAC)
      # Sudo            : $SUDO_AMOUNT cmd
      "
