LOCAL_ARM_MODE := arm

ifndef ANDROID_NDK_ROOT
        $(error ANDROID_NDK_ROOT is undefined - ensure Android NDK is properly configured)
endif

ifndef ANDROID_NDK_SYSROOT
        $(error ANDROID_NDK_SYSROOT is undefined - ensure Android NDK is properly configured)
endif

all: build

build:
	ndk-build NDK_PROJECT_PATH=. APP_BUILD_SCRIPT=./Android.mk

install:
	adb push libs/armeabi/kisskiss /data/local/tmp/

clean:
	rm -rf *.c~
	rm -rf *.h~
	rm -rf obj/