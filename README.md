This is a simple script to automate the process detailed on [https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-3] to install the Arch Linux ARM onto a Raspberry Pi 3/4 (ARMv8 Version).


First, identify the device name using `lsblk` and then run the command as `sudo bash ./arch_pi3_install.bash [drive]`. An example of an installation is as follows:

```text
➜  armv8_arch_pi3_installer git:(main) ✗ lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sdb           8:16   1 119.1G  0 disk 
├─sdb1        8:17   1   200M  0 part 
└─sdb2        8:18   1 118.9G  0 part 
nvme0n1     259:0    0   1.8T  0 disk 
├─nvme0n1p1 259:1    0   100M  0 part /efi
├─ ... (Other drives)
└─nvme0n1pN 259:7    0   XXXG  0 part 
➜  armv8_arch_pi3_installer git:(main) ✗ sudo bash ./arch_pi3_install.bash /dev/sdb
[sudo] password for [username]: 
Verifying MD5 hashes...
Making partitions...
Formatting partitions...
Mounting partitions..
Extracting OS...
Unmounting...
Complete
➜  armv8_arch_pi3_installer git:(main) ✗ 
```
