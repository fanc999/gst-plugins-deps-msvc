# NMake Makefile portion for enabling features for Windows builds

# Optimizations
CFLAGS_FOR_LIB =

!ifdef STATIC
SPEEX_STATIC_CFLAGS = /DSPEEX_STATIC
CFLAGS_FOR_LIB = $(SPEEX_STATIC_CFLAGS)
!else
SPEEX_STATIC_CFLAGS =
CFLAGS_FOR_LIB = /DBUILDING_LIBSPEEX
!endif

SPEEX_TOOLS_DEP_LIBS = ogg.lib winmm.lib user32.lib

BASE_CFLAGS =	\
	/DWIN32	\
	/DHAVE_CONFIG_H	\
	/wd4244 /wd4305 \
	/D_CRT_SECURE_NO_WARNINGS	\
	/D_CRT_NONSTDC_NO_WARNINGS

BASE_INCLUDES = /I..\..\include	/I..

# We build libspeex at least
SPEEX_LIB = vs$(VSVER)\$(CFG)\$(PLAT)\libspeex.lib

BUILT_LIBS = $(SPEEX_LIB)
BUILT_TOOLS =	\
	vs$(VSVER)\$(CFG)\$(PLAT)\speexenc.exe	\
	vs$(VSVER)\$(CFG)\$(PLAT)\speexdec.exe

# Put together the CFLAGS
SPEEX_CFLAGS = $(BASE_CFLAGS) $(CFLAGS_FOR_LIB)
SPEEX_TOOLS_CFLAGS = $(BASE_CFLAGS) $(SPEEX_STATIC_CFLAGS)
