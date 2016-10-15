# Pi Tower


This is the collection of scripts, templates, and other oddities that are
required to setup the six node RPI cluster sitting on my desk. It became
apparent that at major updates I would have to re-flash the SSD drives
with whatever the updated OS is. This means resetting back to vanilla.

I hate doing things manually more than once, so this collection of scripts
should alleviate a majority of the heavy lifting.

## Usage

Right now each script is numbered in terms of its expected run.

#### Getting Started

You'll need to clone this repository on each pi.

```shell
git clone https://github.com/chuckbutler/pi-tower.git
cd pi-tower
sudo install.sh
```

## Expected Pre Reqs

You should have a hypriot prepared SSD and have the SD card set to boot
off of the attached SSD.


Contents of SDCard `cmdline.txt`

```
+dwc_otg.lpm_enable=0 console=tty1 root=/dev/sda2 rootfstype=ext4
cgroup_enable=memory swapaccount=1 elevator=deadline fsck.repair=yes
rootwait console=ttyAMA0,115200 kgdboc=ttyAMA0,115200
```

Flash Hypriot to your SSD (assumed OSX as the workstation, and /dev/disk2 is
the attached SSD


```
dd if=hypriotos-rpi-v1.0.0.img bs=1m of=/dev/rdisk2
```

Plug in both the SSD and the SD card, and boot off your SSD.

From your Raspberry Pi, type the following command to start FDisk:

```
sudo fdisk /dev/sda
```

Then press p and enter to see the partitions. There should only be 2. What
we’re going to do now is delete the Linux partition, but before we do this, we
make a note of the start position for the linux partition sda2. Press d and
then when prompted type 2 and then hit enter. This will delete the partition.

Now we’re going to create a new partition, and make it large enough for the OS
to occupy the full space available on the USB Flash Drive. To do this type `n`
to create a new partition, when prompted to give the partition type, press `p`
for primary. Then it will as for a partition number, press 2 and hit enter.

You will be asked for a first sector, set this as the start of partition 2 as
noted earlier. In my case this as 12280 but this is likely to be different for
you.

After this it will ask for an end position, hit enter to use the default
which is end of disk. Now type `w` to commit the changes.

```
sudo reboot
```

Once your Raspberry Pi has rebooted, we need to resize the partition.
To do this type the following command:

```
sudo resize2fs /dev/sda2
```
Be patient, this will take some time. Once it’s done reboot again. Then type:

```
df -h
```

This will show the partitions and the space, you’ll see the full SSD  space
available now.
