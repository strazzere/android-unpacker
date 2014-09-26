Playdead - Bangcle generic unpacking script
=============

Assumptions made:
 - there is only one device running for adb to connect to (target device)
 - folder named framework/ is full of /system/framework/ files from target device
 - target device have root access (emulator is best and verified)
 - target apk is installed
 - target apk is currently running
 - baksmali and smali are located in ~/bin/*

Works on a year+ old sample and one found as recenty as today (7/16/04)
Older samples may require a 4.3 or lower device, new samples appear to work on 4.4 well

**Usage:**

1. Ensure you have the gdb binary pushed to /data/local/tmp/ and the baksmali/smali and frameworks set up like the scripts references (or change the script).
 Also ensure you only have one device connected and accessable to adb.
 The application you wish to unpack should be installed and running.
<pre>
      $ ./playdead.sh com.package.name.to.unpack    # for linux
</pre>

2. Reverse!

This isn't really a good script, or the best way. Though I wanted to ensure people might have a decent example of getting this type of scripting/unpacking stype working.



Modify
======
<pre>
      $ ./unpack.sh   com.package.name.to.unpack    # for mac
      $ ./playdead.py com.package.name.to.unpack    # for mac/linux/win
</pre>

Download/install gdb for android
======
Run the commands at an adb command line. This will require a working busybox (tar, wget) in your path. Running under a terminal will require adjusting your paths.
<pre>
    $ cd /data/local/tmp
    $ wget http://dan.drown.org/android/gdb-static.tar.gz
    $ tar zxf gdb-static.tar.gz
</pre>
REF :  http://dan.drown.org/android/howto/gdb.html
