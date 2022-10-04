TARGET := iphone:clang:14.5:14.0
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TOOL_NAME = mugunghwahelper

mugunghwahelper_FILES = $(wildcard *.m)
mugunghwahelper_CFLAGS = -fobjc-arc
mugunghwahelper_CODESIGN_FLAGS = -Sentitlements.plist
mugunghwahelper_INSTALL_PATH = /usr/local/bin
mugunghwahelper_PRIVATE_FRAMEWORKS = SpringBoardServices BackBoardServices

include $(THEOS_MAKE_PATH)/tool.mk