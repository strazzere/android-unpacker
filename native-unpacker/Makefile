LOCAL_ARM_MODE := arm

all:
	ndk-build NDK_PROJECT_PATH=. APP_BUILD_SCRIPT=./Android.mk 

install:
	adb push libs/armeabi/kisskiss /data/local/tmp/

clean:
	rm -rf *.c~
	rm -rf *.h~
	rm -rf obj/