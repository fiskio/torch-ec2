MOUNT_DIR=/tmp
MOUNT_DEV=/dev/xvdb

# fail on error, and print out commands as they are run
set -e
set -o xtrace

# prepare and mount the disk
sudo umount $MOUNT_DIR || true
sudo parted -s -a optimal $MOUNT_DEV mklabel gpt -- mkpart primary ext3 1 -1
sudo mkfs -t ext3 $MOUNT_DEV
mkdir -p $MOUNT_DIR
sudo mount $MOUNT_DEV $MOUNT_DIR
sudo chown -R ubuntu:ubuntu $MOUNT_DIR
