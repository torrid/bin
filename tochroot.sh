#!/bin/bash


# This goes to the rootfolder of any chroot environment. Simply call the script (as root)
# from the host OS, it determines it's own root folder and mounts / binds all 
# necessary and convenient folders into the chroot. 

me=$(readlink -f "$0" )
mypath=$(dirname "$me")

echo "# $me - $mypath" 


# mount | grep -q "/usr/src" || mount /dev/Schlonz/Kernels /usr/src/
# mount --bind /usr/src/ $mypath/usr/src/
# mount | grep -q "var/portage" || mount /dev/Virtuals/Portage $mypath/var/portage

mkdir -p $mypath/dev $mypath/sys $mypath/proc

chroot $mypath /bin/mount -t proc none /proc
chroot $mypath /bin/mount -t sysfs none /sys
/bin/mount --rbind /dev $mypath/dev
cat /proc/mounts > $mypath/etc/mtab 
cp /etc/resolv.conf $mypath/etc/
chroot $mypath /bin/bash - 
umount -l $mypath/dev
umount -l $mypath/sys
umount -l $mypath/proc



