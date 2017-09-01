@echo ---------------------------------------------------------------
@echo	              RootME (1.0)
@echo	                  By Ac.3
@echo                  
@echo          Don't drink and root     
@echo ---------------------------------------------------------------
@echo   [*] FEATURES:
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
@echo --- TESTING FOR SU PERMISSIONS ---
@echo  MAKE SURE THAT THE SCREEN IS UNLOCKED 
@echo  and if you get Superuser prompts ACCEPT/ALLOW THEM 
@files\adb shell "su -c 'echo --- Superuser check successful'"
@echo --- Cleaning ---
@files\adb shell "cd /data/local/tmp/; rm *"
@echo --- Installing Busybox 1.22.1 ---
@files\adb push files\busybox /data/local/tmp/.
@echo --- Fixing Permissions ---
@files\adb shell "chmod 755 /data/local/tmp/busybox"
@echo --- Re-Mounting /system ---
@files\adb shell "su -c '/data/local/tmp/busybox mount -o remount,rw /system'"
@echo --- Unrooting ---
@files\adb push files\unroot /data/local/tmp/.
@echo --- Correcting Permissions ---
@files\adb shell "chmod 777 /data/local/tmp/unroot"
@echo --- Executing Script ---
@echo  MAKE SURE THAT THE SCREEN IS UNLOCKED 
@echo  and if you get Superuser prompts ACCEPT/ALLOW THEM 
@files\adb shell "su -c '/data/local/tmp/unroot'"
@echo --- Cleaning Up ---
@files\adb shell "cd /data/local/tmp/; rm *"
@echo --- Rebooting ---
@files\adb reboot
@echo Done
@echo Don't forget to press thanks 
@pause