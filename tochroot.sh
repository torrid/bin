#!/bin/bash


# This goes to the rootfolder of any chroot environment. Simply call the script (as root)
# from the host OS, it determines it's own root folder and mounts / binds all 
# necessary and convenient folders into the chroot. 

me=$(readlink -f "$0" )
mypath=$(dirname "$me")

echo "# $me - $mypath" 


mkdir -p $mypath/dev $mypath/sys $mypath/proc

chroot $mypath /bin/mount -t proc none /proc
chroot $mypath /bin/mount -t sysfs none /sys
               /bin/mount --rbind /dev $mypath/dev
chroot $mypath /bin/mount -o mode=620,gid=5 -t devpts /dev/ptmx /dev/pts
chroot $mypath cat /proc/mounts > /etc/mtab
cp /etc/resolv.conf $mypath/etc/

chroot $mypath /bin/bash - 

umount -l $mypath/dev/pts
umount -l $mypath/dev
umount -l $mypath/sys
umount -l $mypath/proc

