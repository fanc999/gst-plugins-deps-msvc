# NMake Makefile portion for enabling features for Windows builds

# You may change these lines to customize the .lib files that will be linked to
# (libogg only depends on the CRT)

# Please do not change anything beneath this line unless maintaining the NMake Makefiles
# Bare minimum features and sources built into OGG on Windows
OGG_DEFINES = /DWIN32 /I..\include

# Minimal set of (system) libraries needed for the OGG DLL
OGG_DEP_LIBS =

# We build the OGG DLL/LIB at least
OGG_LIBS = $(CFG)\$(PLAT)\ogg.lib

OGG_TESTS = $(CFG)\$(PLAT)\bitwise.exe $(CFG)\$(PLAT)\framing.exe
OGG_TESTS_CFLAGS = /D_V_SELFTEST $(OGG_DEFINES)
OGG_TESTS_DEP_LIBS = $(CFG)\$(PLAT)\ogg.lib

OGG_TESTS = 	\
	$(CFG)\$(PLAT)\bitwise.exe	\
	$(CFG)\$(PLAT)\framing.exe

