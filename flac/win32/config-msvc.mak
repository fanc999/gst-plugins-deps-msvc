# NMake Makefile portion for enabling features for Windows builds

# You may change these lines to customize the .lib files that will be linked to
# (FLAC only depends on libogg)
CFLAGS = $(CFLAGS) /D_CRT_SECURE_NO_WARNINGS /D_CRT_NONSTDC_NO_WARNINGS /wd4244

# Please do not change anything beneath this line unless maintaining the NMake Makefiles
# Bare minimum features and sources built into FLAC on Windows
!if "$(NASM)" == ""
NASM=nasm
!endif

FLAC_BASE_DEFINES = /DWIN32 /I..\include
LIBFLAC_INCLUDES = /I..\src\libFLAC\include
LIBFLAC_BASE_DEFINES =	\
	$(FLAC_BASE_DEFINES)	\
	$(LIBFLAC_INCLUDES)	\
	/D_USE_MATH_DEFINES	\
	/DFLAC__HAS_OGG	\
	/DFLAC__HAS_X86INTRIN	\
	/DFLAC__ALIGN_MALLOC_DATA	\
	/DPACKAGE_VERSION=\"1.3.2\"	\
	/DFLaC__INLINE=_inline	\
	/fp:fast

LIBFLAC_DLL_DEFINES = /DFLAC_API_EXPORTS
LIBFLACPP_DLL_DEFINES = /DFLACPP_API_EXPORTS
LIBFLAC_STATIC_DEFINES = /DFLAC__NO_DLL
TEST_FLAC_DEFINES =	\
	$(FLAC_BASE_DEFINES)	\
	$(LIBFLAC_INCLUDES)	\
	$(LIBFLAC_STATIC_DEFINES)	\
	/DCPU_IS_LITTLE_ENDIAN=1

!if "$(PLAT)" == "x64"
FLAC_ARCH_DEFINES = /DENABLE_64_BIT_WORDS /DFLAC__CPU_X86_64
!else
FLAC_ARCH_DEFINES = /DFLAC__CPU_IA32 /DFLAC__HAS_NASM
!endif

!if $(VSVER) > 9
FLAC_AVX_DEFINES = /arch:AVX
!else
FLAC_AVX_DEFINES =
!endif

LIBFLAC_BASE_DEFINES = $(LIBFLAC_BASE_DEFINES) $(FLAC_ARCH_DEFINES)

# Minimal set of libraries needed for the FLAC DLL
FLAC_DEP_LIBS = ogg.lib

# We build the flac/flac++ DLL/LIB at least
FLAC_LIB = $(CFG)\$(PLAT)\flac.lib
FLACPP_LIB = $(CFG)\$(PLAT)\flac++.lib
FLAC_STATIC_LIB = $(CFG)\$(PLAT)\flac-static.lib

FLAC_LIBS = $(FLAC_LIB) $(FLACPP_LIB)

FLAC_UTILS =	\
	$(CFG)\$(PLAT)\flac.exe	\
	$(CFG)\$(PLAT)\iffscan.exe	\
	$(CFG)\$(PLAT)\metaflac.exe	\
	$(CFG)\$(PLAT)\flactimer.exe	\
	$(CFG)\$(PLAT)\flacdiff.exe	\
	$(CFG)\$(PLAT)\flac-ex-c-decode-file.exe	\
	$(CFG)\$(PLAT)\flac-ex-c-encode-file.exe	\
	$(CFG)\$(PLAT)\flac-ex-cpp-decode-file.exe	\
	$(CFG)\$(PLAT)\flac-ex-cpp-encode-file.exe

FLAC_TESTS = $(CFG)\$(PLAT)\test-flac.exe $(CFG)\$(PLAT)\test-flac++.exe

