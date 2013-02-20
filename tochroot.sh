#!/bin/bash

me=$(readlink -f "$0" )
mypath=$(dirname "$me")

echo "# $me - $mypath" 

mkdir -p $mypath/dev $mypath/sys $mypath/proc

mount | grep -q /dev/Schlonz/Kernels || mount /dev/Schlonz/Kernels /usr/src/
mount --bind /usr/src/ $mypath/usr/src/

mount | grep -q /dev/Virtuals/Portage || mount /dev/Virtuals/Portage $mypath/var/portage

chroot $mypath /bin/mount -t proc none /proc
chroot $mypath /bin/mount -t sysfs none /sys
/bin/mount --rbind /dev $mypath/dev
cat /proc/mounts > $mypath/etc/mtab 
cp /etc/resolv.conf $mypath/etc/
chroot $mypath /bin/bash - 
umount -l $mypath/dev
umount -l $mypath/sys
umount -l $mypath/proc



