#!/bin/bash

echo "Downloading binaries"
rm -rf bin/

mkdir bin/
cd bin/
curl -L -o xpwntool https://github.com/msftguy/ios-jb-tools/raw/master/tools_bin/osx/xpwntool
chmod +x xpwntool
curl -L -o pzb.zip https://api.tihmstar.net/builds/partialZipBrowser/partialZipBrowser-latest.zip
unzip pzb.zip
rm pzb_linux signature.txt latest-sha-partialZipBrowser.txt pzb.zip
chmod +x pzb_macos
git clone https://github.com/dora2-iOS/iBoot32Patcher
cd iBoot32Patcher/
clang iBoot32Patcher.c finders.c functions.c patchers.c -Wno-multichar -I. -o iBoot32Patcher
mv iBoot32Patcher ../iBootPatcher
cd ..
rm -rf iBoot32Patcher/
mv iBootPatcher iBoot32Patcher
cd ..

echo "Removing previous files..."
rm -rf boot/

mkdir tmp/
cd tmp/
../bin/pzb_macos -g Firmware/dfu/iBSS.n81ap.RELEASE.dfu https://secure-appldnld.apple.com/iOS6.1/031-3211.20140221.Placef/iPod4,1_6.1.6_10B500_Restore.ipsw
../bin/pzb_macos -g Firmware/dfu/iBEC.n81ap.RELEASE.dfu https://secure-appldnld.apple.com/iOS6.1/031-3211.20140221.Placef/iPod4,1_6.1.6_10B500_Restore.ipsw
../bin/pzb_macos -g Firmware/all_flash/all_flash.n90ap.production/DeviceTree.n90ap.img3 https://secure-appldnld.apple.com/iOS7/091-9485.20130918.Xa98u/iPhone3,1_7.0_11A465_Restore.ipsw
../bin/pzb_macos -g kernelcache.release.n90 https://secure-appldnld.apple.com/iOS7/091-9485.20130918.Xa98u/iPhone3,1_7.0_11A465_Restore.ipsw
../bin/xpwntool iBSS.n81ap.RELEASE.dfu iBSS.dec -iv daafc6ddd42c8f807000b9c1dd453236 -k 1e68d69064ca17c6717be4fa4ff09a71eba1ad0af2a96df4b99a69f6e7258058
../bin/iBoot32Patcher iBSS.dec iBSS.patched --rsa
../bin/xpwntool iBSS.patched ibss -t iBSS.n81ap.RELEASE.dfu
rm iBSS.patched iBSS.n81ap.RELEASE.dfu iBSS.dec
../bin/xpwntool iBEC.n81ap.RELEASE.dfu iBEC.dec -iv fb44e5dbd3eb75d20f83c0f14d452346 -k 12a5192b4a2e860a76e9368e18e182e5f9f4809dcba62098fcbbaa63ef998a3c
../bin/iBoot32Patcher iBEC.dec iBEC.patched --rsa --ticket -b "-v"
../bin/xpwntool iBEC.patched ibec -t iBEC.n81ap.RELEASE.dfu
rm iBEC.patched iBEC.n81ap.RELEASE.dfu iBEC.dec
../bin/xpwntool DeviceTree.n90ap.img3 devicetree.dec -iv e192230b85dd41e6f2c38c725bce55bb -k 27e9fb09aa1af2f3e690a74d6e077980f66e498a38f03b6e1383d845c73d8ece
../bin/xpwntool devicetree.dec devicetree -t DeviceTree.n90ap.img3
rm DeviceTree.n90ap.img3 devicetree.dec
mv kernelcache.release.n90 kernelcache
mkdir ../boot
mv ibss ../boot/ibss
mv ibec ../boot/ibec
mv devicetree ../boot/devicetree
mv kernelcache ../boot/kernelcache
cd ..
rm -r tmp/
rm -rf bin/

echo "*****************************"
echo "Done."
echo "Now boot with irecovery."
echo "-lychi (2022)"
