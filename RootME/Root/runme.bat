@echo ---------------------------------------------------------------
@echo	              RootME (1.0)
@echo	                  By Ac.3
@echo                  
@echo          Don't drink and root     
@echo ---------------------------------------------------------------
@echo   [*] FEATURES:
@echo            Rooting
@echo            Unrooting
@echo            Busybox removal
@echo 
@echo   [*] Requirements:
@echo           ADB Installed
@echo           USB DEBUGGING Enabled   
@echo           UNKNOWN SOURCES Enabled
@echo           [OPTIONAL] Increase Screen Timeout To 10 Minutes
@echo           Connect USB Cable To PHONE and Then Connect to PC
@echo           Skip \"PC Companion Software\" Prompt On Device
@echo 
@echo 
@echo ---------------------------------------------------------------
@echo MAKE SURE THAT THE SCREEN IS UNLOCKED
@echo and if you get Superuser prompts ACCEPT/ALLOW THEM 
@echo ---------------------------------------------------------------
@pause
@echo --- STARTING ----
@echo --- Starting ADB ---
@files\adb wait-for-device
@echo --- Generating /tmp ---
@files\adb shell "cd /data/local && mkdir tmp"
@echo --- Cleaning ---
@files\adb shell "cd /data/local/tmp/ && rm *"
@files\adb wait-for-device
@echo --- DEVICE FOUND
@echo --- Installing Busybox 1.22.1 ---
@files\adb push files\busybox /data/local/tmp/.
@echo --- Correcting Permissions
@files\adb shell "chmod 755 /data/local/tmp/busybox"
@echo --- Re-Mounting /system
@files\adb shell "/data/local/tmp/busybox mount -o remount,rw /system"
@echo --- Checking Free Space /system
@files\adb push files\makespace /data/local/tmp/.
@files\adb shell "chmod 777 /data/local/tmp/makespace"
@files\adb shell "./data/local/tmp/makespace"
@echo --- Copying Files ---
@files\adb shell "dd if=/data/local/tmp/busybox of=/system/xbin/busybox"
@echo --- Correcting Ownership
@files\adb shell "chown root.shell /system/xbin/busybox"
@echo --- Correcting Permissions
@files\adb shell "chmod 04755 /system/xbin/busybox"
@echo --- Installing
@files\adb shell "/system/xbin/busybox --install -s /system/xbin"
@files\adb shell "rm -r /data/local/tmp/busybox"
@echo --- SU Binary ---
@files\adb push files\su /system/bin/su
@echo --- Correcting Ownership ---
@files\adb shell "chown root.shell /system/bin/su"
@echo --- Correcting Permissions ---
@files\adb shell "chmod 06755 /system/bin/su"
@echo --- Correcting Symlinks ---
@files\adb shell "rm /system/xbin/su"
@files\adb shell "ln -s /system/bin/su /system/xbin/su"

@echo --- Superuser.apk
@files\adb push files\Superuser.apk /system/app/.
@echo --- Cleaning ---
@files\adb shell "cd /data/local/tmp/; rm *"
@echo --- Rebooting ---
@files\adb reboot
@echo ALL DONE
@pause