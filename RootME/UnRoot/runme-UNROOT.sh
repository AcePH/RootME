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
echo "MAKE SURE THAT THE SCREEN IS UNLOCKED"
echo "and if you get Superuser prompts ACCEPT/ALLOW THEM" 
echo "---------------------------------------------------------------"

echo ""
read -p "Press [Enter] to continue..."

echo ""
echo "--- STARTING ----"
echo "Starting ADB"
$RUN wait-for-device


echo "--- Testing for permission ---"
$RUN shell "su -c 'echo --- Superuser Check Successful ---'"
sleep 3
echo ""
echo "--- Cleaning ---"
$RUN shell "cd /data/local/tmp/; rm *"
sleep 1
echo "--- Installing Latest Busybox ---"
$RUN push ./files/busybox "/data/local/tmp/."
sleep 1
echo "  --- Fixing Permissions ---"
$RUN shell "chmod 755 /data/local/tmp/busybox"
sleep 1
echo "  --- Re-mounting /system"
echo "MAKE SURE THAT THE SCREEN IS UNLOCKED"
$RUN shell "su -c '/data/local/tmp/busybox mount -o remount,rw /system'"

sleep 1
# unroot
echo "UNROOTING"
$RUN push ./files/unroot "/data/local/tmp/."
echo "  --- Fixing Permissions ---"
$RUN shell "chmod 777 /data/local/tmp/unroot"
echo "  --- Finishing Up --- "
$RUN shell "su -c '/data/local/tmp/unroot'"

echo "--- Cleaning ---"
echo "--- cleaning /data/local/tmp/"
$RUN shell "cd /data/local/tmp/; rm *"
echo "--- Rebooting"
$RUN reboot
echo "Done"
echo "Don't forget to press thanks :D"