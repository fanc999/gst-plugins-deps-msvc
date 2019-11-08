# NMake Makefile portion for enabling features for Windows builds

# You may change these lines to customize the .lib files that will be linked to
# (libvorbis only depends on libogg)
CFLAGS = $(CFLAGS) /D_CRT_SECURE_NO_WARNINGS /D_CRT_NONSTDC_NO_WARNINGS /wd4244

# Please do not change anything beneath this line unless maintaining the NMake Makefiles
# Bare minimum features and sources built into Vorbis on Windows
VORBIS_DEFINES = /DWIN32 /I..\include
VORBIS_EX_DEFINES = /Doff_t=int $(VORBIS_DEFINES)
!if $(VSVER) < 14
VORBIS_TEST_DEFINES = /Dsnprintf=_snprintf /D_USE_MATH_DEFINES $(VORBIS_DEFINES)
!else
VORBIS_TEST_DEFINES = /D_USE_MATH_DEFINES $(VORBIS_DEFINES)
!endif

# Minimal set of libraries needed for the Vorbis DLL
VORBIS_DEP_LIBS = ogg.lib

# We build the Vorbis/VorbisEnc/VorbisFile DLL/LIB at least
VORBIS_LIB = $(CFG)\$(PLAT)\vorbis.lib
VORBISENC_LIB = $(CFG)\$(PLAT)\vorbisenc.lib
VORBISFILE_LIB = $(CFG)\$(PLAT)\vorbisfile.lib

VORBIS_LIBS = $(VORBIS_LIB) $(VORBISENC_LIB) $(VORBISFILE_LIB)

VORBIS_TESTS = $(CFG)\$(PLAT)\vorbis-test.exe

VORBIS_EXAMPLES = 	\
	$(CFG)\$(PLAT)\vorbis-ex-chaining.exe	\
	$(CFG)\$(PLAT)\vorbis-ex-decoder.exe	\
	$(CFG)\$(PLAT)\vorbis-ex-encoder.exe	\
	$(CFG)\$(PLAT)\vorbis-ex-seeking.exe	\
	$(CFG)\$(PLAT)\vorbis-ex-vorbisfile.exe

