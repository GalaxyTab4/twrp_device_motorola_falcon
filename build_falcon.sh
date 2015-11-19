#!/bin/bash

toolchain="$1";
version="$2";
zipname="";
tcname="";

echo -e "Making Moto G (Falcon) zImage...";

# Setup the compiler according to toolchain
case $toolchain in
	"archi")
		echo -e "Toolchain being used: ArchiToolchain v5.1 for Cortex-A7\n";
		export PATH=$HOME/Toolchains/ArchiDroid-5.1-A7/bin:$PATH;
		export ARCH=arm;
		export SUBARCH=arm;
		export CROSS_COMPILE=arm-architoolchain-linux-gnueabihf-;
		tcname="ArchiDroid";
	;;
	"linaro" | "linaro_4.9" | "" | " ")
		echo -e "Toolchain being used: Linaro 4.9.4 for Cortex-A7\n";
		export PATH=$HOME/Toolchains/Linaro-4.9.4-A7/bin:$PATH;
		export ARCH=arm;
		export SUBARCH=arm;
		export CROSS_COMPILE=arm-cortex_a7-linux-gnueabihf-;
		tcname="Linaro4.9";
	;;
	"linaro_5.1")
		echo -e "Toolchain being used: Linaro 5.1\n";
		export PATH=$HOME/Toolchains/Linaro-5.1/bin:$PATH;
		export ARCH=arm;
		export SUBARCH=arm;
		export CROSS_COMPILE=arm-linux-gnueabihf-;
		tcname="Linaro5.1";
	;;
	"saber" | "saber_4.9")
		echo -e "Toolchain being used: SaberMod 4.9\n";
		export PATH=/kernel/BKP/arm-eabi-4.9-sm/bin:$PATH;
		export ARCH=arm;
		export SUBARCH=arm;
		export CROSS_COMPILE=arm-eabi-;
		tcname="SaberMod4.9";
	;;
	"saber_6.0")
		echo -e "Toolchain being used: SaberMod 6.0\n";
		export PATH=$HOME/Toolchains/SaberMod-6.0/bin:$PATH;
		export ARCH=arm;
		export SUBARCH=arm;
		export CROSS_COMPILE=arm-eabi-;
		tcname="SaberMod6.0";
	;;
	*)
		echo -e "Invalid option. Aborting."
		exit 1;
	;;
esac;

# Print version number
case $version in
	"" | " ")
		echo -e "Version number: None\n";;
	*)
		echo -e "Version number: "$version;;
esac;

# Build the kernel
make sub77/falcon_defconfig;

make -j24;

# make dirs if they don't exist
if [ ! -d ../zip_falcon ]; then mkdir ../zip_falcon; fi;
if [ ! -d ../zip_falcon/modules ]; then mkdir ../zip_falcon/modules; fi;
if [ ! -d ../release_falcon ]; then mkdir ../release_falcon; fi;

# Remove previous modules
if [ -d ../zip_falcon/modules ]; then rm -rf ../zip_falcon/modules/*; fi;

# make dirs part 2
if [ ! -d ../zip_falcon/modules/pronto ]; then mkdir ../zip_falcon/modules/pronto; fi;

# modules
# find ./ -type f -name '*.ko' -exec cp -f {} ../zip_falcon/modules/ \;
# mv ../zip_falcon/modules/wlan.ko ../zip_falcon/modules/pronto/pronto_wlan.ko

# copy zImage
cp -f arch/arm/boot/zImage ../zip_falcon/;
ls -l ../zip_falcon/zImage;
cd ../zip_falcon;

# Set zip name
case $version in
	"" | " ")
		zipname="Kaminari-Falcon-Neue-"$tcname;
	;;
	*)
		zipname="Kaminari-Falcon-v"$version"-"$tcname;
		;;
esac;

zip -r9 $zipname.zip * > /dev/null;
mv $zipname.zip ../release_falcon;




