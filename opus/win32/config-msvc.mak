# NMake Makefile portion for enabling features for Windows builds

# You may change these lines to customize the .lib files that will be linked to
# (libopus only depends on the CRT)
CFLAGS = $(CFLAGS) /D_CRT_SECURE_NO_WARNINGS /D_CRT_NONSTDC_NO_WARNINGS /wd4244

# Please do not change anything beneath this line unless maintaining the NMake Makefiles
# Bare minimum features and sources built into Opus on Windows
OPUS_DEFINES = /DWIN32 /I..\include /DHAVE_CONFIG_H 
LIBOPUS_BASE_CFLAGS = /I..\silk\fixed /I..\silk\float /I.. /I..\silk /I..\celt /I..\win32 /I$(CFG)\$(PLAT)\libopus 
LIBOPUS_DEFINES = /DOPUS_EXPORTS $(OPUS_DEFINES) /DDLL_EXPORT /Zp16 /Ot

!if $(VSVER) > 10
!if "$(PLAT)" == "Win32"
LIBOPUS_DEFINES = /arch:IA32 $(LIBOPUS_DEFINES)
!endif
!endif

!if "$(FIXED_POINT)" == "1"
LIBOPUS_DEFINES = /DFIXED_POINT $(LIBOPUS_DEFINES)
!endif

# Minimal set of libraries needed for the Opus DLL
OPUS_DEP_LIBS = ogg.lib

# We build the Opus DLL/LIB at least
OPUS_LIB = $(CFG)\$(PLAT)\opus.lib

OPUS_DEMO_OBJ = $(CFG)\$(PLAT)\demo\opus_demo.obj
OPUS_TEST_API_OBJ = $(CFG)\$(PLAT)\tests\test_opus_api.obj
OPUS_TEST_DECODE_OBJ = $(CFG)\$(PLAT)\tests\test_opus_decode.obj
OPUS_TEST_ENCODE_OBJS =	\
	$(CFG)\$(PLAT)\tests\test_opus_encode.obj	\
	$(CFG)\$(PLAT)\tests\opus_encode_regressions.obj
OPUS_TEST_PADDING_OBJ = $(CFG)\$(PLAT)\tests\test_opus_padding.obj

OPUS_TESTS =	\
	$(CFG)\$(PLAT)\test-opus-api.exe	\
	$(CFG)\$(PLAT)\test-opus-decode.exe	\
	$(CFG)\$(PLAT)\test-opus-encode.exe	\
	$(CFG)\$(PLAT)\test-opus-padding.exe

OPUS_DEMOS = $(CFG)\$(PLAT)\opus-demo.exe

