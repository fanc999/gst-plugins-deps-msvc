# NMake Makefile portion for enabling features for Windows builds

# Optimizations
CFLAGS_FOR_LIB =

!ifndef STATIC
CFLAGS_FOR_LIB = /DKATE_EXTERN="__declspec (dllexport) extern"
!else
CFLAGS_FOR_LIB = /DBUILDING_LIBSPEEX
!endif

OGG_LIB = ogg.lib
PNG_LIBS = libpng16.lib zlib1.lib

BASE_CFLAGS =	\
	/DWIN32	\
	/DHAVE_CONFIG_H	\
	/wd4244 /wd4305 /wd4308	\
	/D_CRT_SECURE_NO_WARNINGS	\
	/D_CRT_NONSTDC_NO_WARNINGS

BASE_INCLUDES = /I..\..\..\..\include
TOOLS_INCLUDES = $(BASE_INCLUDES) /I..\..\..\..\src
TOOLS_CFLAGS = $(BASE_CFLAGS) /DYY_NO_UNISTD_H /FIinttypes.h

# We build libkate at least
KATE_LIB = vs$(VSVER)\$(CFG)\$(PLAT)\libkate.lib
KATE_OGG_LIB = vs$(VSVER)\$(CFG)\$(PLAT)\liboggkate.lib

BUILT_LIBS = $(KATE_LIB) $(KATE_OGG_LIB)

!ifdef TOOLS
BUILT_TOOLS =	\
	vs$(VSVER)\$(CFG)\$(PLAT)\kateenc.exe	\
	vs$(VSVER)\$(CFG)\$(PLAT)\katedec.exe	\
	vs$(VSVER)\$(CFG)\$(PLAT)\katalyzer.exe

KATE_TOOLS_DEP_LIBS = $(OGG_LIB)

!ifdef PNG
KATE_TOOLS_DEP_LIBS = $(PNG_LIBS) $(KATE_TOOLS_DEP_LIBS)
TOOLS_CFLAGS = $(TOOLS_CFLAGS) /DHAVE_PNG
!endif

!if $(VSVER) < 14
TOOLS_CFLAGS = $(TOOLS_CFLAGS) /Dsnprintf=_snprintf
!endif
!endif

# Put together the CFLAGS
LIBKATE_CFLAGS = $(BASE_CFLAGS) $(CFLAGS_FOR_LIB)
