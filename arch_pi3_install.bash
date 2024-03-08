#! /bin/bash

# Check root
if [[ `whoami` != 'root' ]]; then
    echo "Script must be run as root, try again"
    exit
fi

# Download URLs
FILE_URL='http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-aarch64-latest.tar.gz'
MD5_URL='http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-aarch64-latest.tar.gz.md5'

# Extract file names
FILE_NAME=$(basename $FILE_URL)
MD5_NAME=$(basename $MD5_URL)

# Download arch if it doesn't exist
SEARCH=$(ls | grep $FILE_NAME)
if [[ $SEARCH == "" ]]; then
    wget $FILE_URL > /dev/null 2>&1
fi

# Remove hash if it exists and update it
SEARCH=$(ls | grep $MD5_NAME)
if [[ $SEARCH != "" ]]; then
    rm $MD5_NAME
fi
wget $MD5_URL > /dev/null 2>&1

# Verify hash
echo "Verifying MD5 hashes..."
HASH_VERIFY=$(cat $MD5_NAME)
HASH=$(md5sum $FILE_NAME)
if [[ $HASH != $HASH_VERIFY ]]; then
    echo "MD5 hash for downloaded ARM Arch Linux tar does not match expected"
    exit
fi

# Make partitions
echo "Making partitions..."
sfdisk -f $1 < sda.sfdisk > /dev/null 2>&1

# Format
echo "Formatting partitions..."
mkfs.vfat $1'1' > /dev/null 2>&1
mkfs.ext4 $1'2' > /dev/null 2>&1

# Mount
echo "Mounting partitions.."
mkdir boot
mkdir root
mount $1'1' boot > /dev/null 2>&1
mount $1'2' root > /dev/null 2>&1

# Extract
echo "Extracting OS..."
bsdtar -xpf $FILE_NAME -C root > /dev/null 2>&1
sync > /dev/null 2>&1
mv ./root/boot/* ./boot

echo "Unmounting..."
umount boot root > /dev/null 2>&1

# Remove
rm boot root -r

echo "Complete"
