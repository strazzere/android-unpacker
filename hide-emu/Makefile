LOCAL_ARM_MODE := arm

all:
	ndk-build NDK_PROJECT_PATH=. APP_BUILD_SCRIPT=./Android.mk 

install:
	adb push libs/armeabi/libhide.so /data/local/tmp/libhide.so

clean:
	rm -rf libs/
	rm -rf obj/
	rm *~
