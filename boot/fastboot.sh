#!/bin/bash

export FASTBOOT=${FASTBOOT-"./../../../../out/host/linux-x86/bin/fastboot"}
export PRODUCT_OUT=${PRODUCT_OUT-"./"}

usage ()
{
	echo "Usage: %fasboot.sh < --emu|--gp >";
	exit 1;
}

#no args case
if [ "$1x" = "x" ] ; then
	usage
fi

#one or more args
while [ "$#" -gt 0 ]
	do
	case "$1" in
		--emu) echo "EMU device"; export MLO=MLO_es2.2_emu; shift;;
		--gp)  echo "GP device";  export MLO=MLO_es2.2_gp;  shift;;
		*)   usage; shift;;
	esac
done

echo "Flashing bootloader....."
$FASTBOOT flash xloader 	./boot/$MLO
$FASTBOOT flash bootloader 	./boot/u-boot.bin

echo "Reboot: make sure new bootloader runs..."
$FASTBOOT reboot-bootloader

sleep 5

echo "Create GPT partition table"
$FASTBOOT oem format

echo "Flash android partitions"
$FASTBOOT flash boot 		$PRODUCT_OUT/boot.img
$FASTBOOT flash recovery	$PRODUCT_OUT/recovery.img
$FASTBOOT flash system 		$PRODUCT_OUT/system.img
$FASTBOOT flash userdata 	$PRODUCT_OUT/userdata.img

#Create cache.img
if [ ! -f cache.img ]
then
	echo "Creating cache.img as empty ext4 img...."
	rm -rf /tmp/fastboot-cache
	mkdir /tmp/fastboot-cache
	./../../../../out/host/linux-x86/bin/make_ext4fs -s -l 256M -a cache cache.img /tmp/fastboot-cache/
	rm -rf /tmp/fastboot-cache
fi

#flash cache.img
$FASTBOOT flash cache 		./cache.img
