# ipod4-7.0-boot

This is a script to generate files to boot iPod4,1 running 7.0 (11A465) without the use of python and custom KeysServer with futurerestore.

To run the script, run the command `./patch.sh` in Terminal.

The script will automatically download and patch the necessary files.

You should be left with a folder named `boot`.

Within the folder are four files: `ibss`, `ibec`, `devicetree`, and `kernelcache`.

Run the following commands in this order to boot the device with irecovery after the device is in pwnedDFU mode.
```
irecovery -f ibss
irecovery -f ibec
irecovery -f devicetree
irecovery -c devicetree
irecovery -f kernelcache
irecovery -c bootx
```
The iBSS and iBEC come from the stock iPod4,1 6.1.6 IPSW. iBSS has an RSA patch on it through iBoot32Patcher and iBEC has an RSA, ticket, and -v boot-arg patch on it through iBoot32Patcher.

DeviceTree and Kernelcache come from the iPhone3,1 7.0 (11A465) IPSW. DeviceTree is decrypted using xpwntool, while the Kernelcache is untouched from the IPSW.

Enjoy.


-lychi (2022)

CREDITS:
ih8sn0w and dora2iOS for iBoot32Patcher
planetbeing for xpwn/xpwntool
tihmstar for partialZipBrowser
