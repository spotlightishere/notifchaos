TARGET := iphone:clang:latest:12.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = notifchaos

notifchaos_FILES = Tweak.x
notifchaos_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
