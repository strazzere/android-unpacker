Kisskiss - Unpacker for various Android packers/protectors
=============

Basic example of an easy unpacker for Android. Heavily commented so hopefully people can understand the flow and thinking behind the hacks going on.

Currently supports:
 - Bangcle (SecNeo)
 - APKProtect
 - LIAPP (prerelease demo)
 - Qihoo Android Packers

**Usage:**

1. Compile: (Assumes ndk-build and $ANDROID_NDK_SYSROOT are properly set)
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
