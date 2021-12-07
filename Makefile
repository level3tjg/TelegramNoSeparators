TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = Telegram 

ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TelegramNoSeparators

TelegramNoSeparators_FILES = Tweak.x
TelegramNoSeparators_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
