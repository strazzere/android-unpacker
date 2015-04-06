Generic gdb unpacking scripts
=============
Assumptions made:
- there is only one device running for adb to connect to (target device)
- folder named framework/ is full of /system/framework/ files from target device
- target device have root access (emulator is best and verified)
- target apk is installed
- target apk is currently running
- baksmali and smali are located in ~/bin/*
- gdb binary is pushed to /data/local/tmp/

Playdead - Bangcle unpacking script
--------
Works on a year+ old sample and one found as recenty as today (7/16/04)
Older samples may require a 4.3 or lower device, new samples appear to work on 4.4 well

**Usage:**

1. Ensure you have the gdb binary pushed to /data/local/tmp/ and the baksmali/smali and frameworks set up like the scripts references (or change the script).
Also ensure you only have one device connected and accessable to adb.
The application you wish to unpack should be installed and running.
<pre>
$ ./playdead.sh com.package.name.to.unpack
</pre>

2. Reverse!

This isn't really a good script, or the best way. Though I wanted to ensure people might have a decent example of getting this type of scripting/unpacking type working.


Playnice - Secshell unpacking script
--------
Works almost identically to playdead with similar assumptions,
but scans for a DEX header instead of ODEX, and uses gdb find instead of examine.

**Usage:**

<pre>
$ ./playnice.sh com.package.name.to.unpack
</pre>
