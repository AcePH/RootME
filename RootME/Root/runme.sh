RUN=adb
echo "---------------------------------------------------------------"
echo "                        RootME (1.0)                           "
echo "                         By Ac.3                               "
echo "                                                               "
echo "                    Don't drink and root                       "
echo "---------------------------------------------------------------"
echo " [*] FEATURES:"
echo "      Unrooting"
echo "      Busybox removal"
echo ""
echo " [*] Requirements:"
echo "      ADB Installed"
echo "      USB DEBUGGING Enabled"    
echo "      UNKNOWN SOURCES Enabled"
echo "      [OPTIONAL] Increase Screen Timeout To 10 Minutes"
echo "      Connect USB Cable To PHONE and Then Connect to PC"
echo "      Skip \"PC Companion Software\" Prompt On Device"
echo ""
echo ""
echo "---------------------------------------------------------------"
echo "MAKE SURE THAT THE SCREEN IS UNLOCKED                          "
echo "and if you get Superuser prompts ACCEPT/ALLOW THEM             " 
echo "---------------------------------------------------------------"

echo ""
read -p "Press [Enter] to continue..."

echo ""

echo "--- STARTING ----"
echo "Starting ADB"
$RUN wait-for-device

# /tmp
echo ""
echo "--- Generating /tmp --- "
$RUN shell "cd /data/local && mkdir tmp"
echo "--- Cleaning /data/local/tmp/"
$RUN shell "cd /data/local/tmp/ && rm *"

# Busybox
echo ""
echo "--- Installing Busybox 1.22.1 Bionic ---"
$RUN push ./files/busybox "/data/local/tmp/."
echo "  --- Fixing Permissions ---"
$RUN shell "chmod 755 /data/local/tmp/busybox"
echo "  --- Re-mounting /system"
$RUN shell "/data/local/tmp/busybox mount -o remount,rw /system"
echo "  --- Checking free space /system"
sleep 3
echo "--- Pushing Makespace to Device ---"
$RUN push ./files/makespace /data/local/tmp/.
echo "    --- Fixing Permissions ---"
$RUN shell "chmod 777 /data/local/tmp/makespace"
echo "    --- Executing --- "
$RUN shell "/data/local/tmp/makespace"
echo "  --- Copying Necessary Files"
$RUN shell "dd if=/data/local/tmp/busybox of=/system/xbin/busybox"
echo "  --- Fixing Ownership ---"
$RUN shell "chown root.shell /system/xbin/busybox"
echo "  --- Finishing Up ---"
$RUN shell "chmod 04755 /system/xbin/busybox"
echo "  --- Installing ---"
$RUN shell "/system/xbin/busybox --install -s /system/xbin"
$RUN shell "rm -r /data/local/tmp/busybox"

# SU Binaries
echo ""
echo "--- Pushing SU binary ---"
$RUN push ./files/su /system/bin/su
echo "  --- Fixing Ownership ---"
$RUN shell "chown root.shell /system/bin/su"
echo "  --- Fixing Permissions ---"
$RUN shell "chmod 06755 /system/bin/su"
echo "  --- Correcting Symlink ---"
$RUN shell "rm /system/xbin/su"
$RUN shell "ln -s /system/bin/su /system/xbin/su"

# Superuser app
echo ""
echo "--- Superuser.apk ---"
$RUN push ./files/Superuser.apk "/system/app/."

echo ""
echo "--- Cleaning /data/local/tmp/"
$RUN shell "cd /data/local/tmp/; rm *"
echo "--- Rebooting ---"
$RUN reboot
echo "Done"
echo "Don't forget to press thanks"