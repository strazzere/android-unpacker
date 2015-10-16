Kisskiss - Unpacker for various Android packers/protectors
=============

Basic example of an easy unpacker for Android. Heavily commented so hopefully people can understand the flow and thinking behind the hacks going on.

Currently supports:
 - Bangcle (SecNeo)
 - APKProtect
 - LIAPP (prerelease demo)
 - Qihoo Android Packers

This _should_ work on ARM and x86 devices. Please note that ptrace can and often is disabled or messed up on newer SELinux devices. You should either use a device/emulator which does not have SELinux enabled or disable it prior to ruinning this.

**Compiling:**

The only prerequisite for the unpacker to build is to have the Android NDK [installed](https://developer.android.com/ndk/guides/setup.html#install).

**Usage:**

1. Compile: (Assumes the NDK was properly installed and `PATH` variable updated, see link above)
<pre>
      $ make
</pre>

2. Push to the device
<pre>
      $ make install
</pre>

2. Run the APK to unpack and then run the unpacker
<pre>
      $adb shell ./data/local/tmp/kisskiss com.package.name.to.unpack
</pre>

Follow the outputs instructions and pull the odex, deodex as needed and enjoy reversing!
