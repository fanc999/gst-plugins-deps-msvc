# NMake Makefile portion for enabling features for Windows builds

# Optimizations
CFLAGS_FOR_LIB = /DLIBTWOLAME_BUILD

!ifdef STATIC
CFLAGS_FOR_LIB = $(CFLAGS_FOR_LIB) /DLIBTWOLAME_STATIC
CFLAGS_TOOLS = $(CFLAGS_FOR_LIB)
!else
CFLAGS_FOR_LIB = $(CFLAGS_FOR_LIB) /DDLL_EXPORT
CFLAGS_TOOLS =
!endif

BASE_CFLAGS =	\
	/DWIN32		\
	/wd4244		\
	/D_CRT_SECURE_NO_WARNINGS	\
	/D_CRT_NONSTDC_NO_WARNINGS

BASE_INCLUDES = /I..\libtwolame /I..\win32

# We build libtwolame at least
TWOLAME_LIB = vs$(VSVER)\$(CFG)\$(PLAT)\twolame.lib

BUILT_LIBS = $(TWOLAME_LIB)

# Put together the CFLAGS
LIBTWOLAME_CFLAGS = $(BASE_CFLAGS) $(CFLAGS_FOR_LIB)
