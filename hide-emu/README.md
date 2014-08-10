StupidQemuHide
=============

Very basic ld_preload hack to circumvent the anti-qemud detection in APKProtect

**Usage:**

1. Compile: (Assumes ndk-build and $SYSROOT are properly set)
<pre>
      $ make
</pre>

2. Push to the device
<pre>
      $ make install
</pre>

2. preload the library and run the command you want to hook:
<pre>
      $adb shell
      #setprop wrap.%PACKAGE_NAME% LD_PRELOAD=/data/local/tmp/libhide.so
</pre>

Run the APK, it should not be wrapped - though it will be much more slow since this is a bad hack.
