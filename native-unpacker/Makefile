LOCAL_ARM_MODE := arm

all: check build

check:
ifeq (, $(shell which ndk-build))
        $(error "No 'ndk-build' in PATH, please install Android NDK and configure properly")
endif

build:
	ndk-build NDK_PROJECT_PATH=. APP_BUILD_SCRIPT=./Android.mk

install:
	adb push libs/armeabi/kisskiss /data/local/tmp/

clean:
	rm -rf *.c~
	rm -rf *.h~
	rm -rf obj/