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

!if !defined (NO_SSE) && "$(PLAT)" != "x64"
CFLAGS_FOR_LIB = $(CFLAGS_FOR_LIB) /arch:SSE
!endif

!if !defined (NO_SSE2) && "$(PLAT)" != "x64"
CFLAGS_FOR_LIB = $(CFLAGS_FOR_LIB) /arch:SSE2
!endif

!if (defined (NO_SSE) || defined (NO_SSE2)) && "$(PLAT)" == "x64"
!message SSE and SSE2 are always built into x64 builds.
!endif

!ifdef FIXED_POINT
!if defined (NO_SSE2) && defined (NO_SSE) && "$(PLAT)" != "x64"
!ifdef VORBIS
!error Vorbis Pyscho support not supported for fixed point implementation
!endif
CFLAGS_FOR_LIB = $(CFLAGS_FOR_LIB) /DFIXED_POINT
!else
!error fixed point implementation not allowed on SSE nor SSE2
!endif
!else
!ifdef VORBIS
CFLAGS_FOR_LIB = $(CFLAGS_FOR_LIB) /DVORBIS_PSYCHO /FImalloc.h /D_USE_MATH_DEFINES
!endif
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
