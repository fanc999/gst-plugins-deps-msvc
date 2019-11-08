# Convert the source listing to object (.obj) listing in
# another NMake Makefile module, include it, and clean it up.
# This is a "fact-of-life" regarding NMake Makefiles...
# This file does not need to be changed unless one is maintaining the NMake Makefiles

# For those wanting to add things here:
# To add a list, do the following:
# # $(description_of_list)
# if [call create-lists.bat header $(makefile_snippet_file) $(variable_name)]
# endif
#
# if [call create-lists.bat file $(makefile_snippet_file) $(file_name)]
# endif
#
# if [call create-lists.bat footer $(makefile_snippet_file)]
# endif
# ... (repeat the if [call ...] lines in the above order if needed)
# !include $(makefile_snippet_file)
#
# (add the following after checking the entries in $(makefile_snippet_file) is correct)
# (the batch script appends to $(makefile_snippet_file), you will need to clear the file unless the following line is added)
#!if [del /f /q $(makefile_snippet_file)]
#!endif

# In order to obtain the .obj filename that is needed for NMake Makefiles to build DLLs/static LIBs or EXEs, do the following
# instead when doing 'if [call create-lists.bat file $(makefile_snippet_file) $(file_name)]'
# (repeat if there are multiple $(srcext)'s in $(source_list), ignore any headers):
# !if [for %c in ($(source_list)) do @if "%~xc" == ".$(srcext)" @call create-lists.bat file $(makefile_snippet_file) $(intdir)\%~nc.obj]
#
# $(intdir)\%~nc.obj needs to correspond to the rules added in build-rules-msvc.mak
# %~xc gives the file extension of a given file, %c in this case, so if %c is a.cc, %~xc means .cc
# %~nc gives the file name of a given file without extension, %c in this case, so if %c is a.cc, %~nc means a

NULL=

# For shared sources
FLAC_WIN32_SHARED_SRC = ..\src\libFLAC\windows_unicode_filenames.c
FLAC_GETOPT_SRCS = ..\src\getopt\getopt.c ..\src\getopt\getopt1.c

FLAC_GRABBAG_SRCS =	\
	..\src\share\grabbag\alloc.c	\
	..\src\share\grabbag\cuesheet.c	\
	..\src\share\grabbag\file.c	\
	..\src\share\grabbag\picture.c	\
	..\src\share\grabbag\replaygain.c	\
	..\src\share\grabbag\seektable.c	\
	..\src\share\grabbag\snprintf.c

FLAC_REPLAYGAIN_ANALYSIS_SRC = ..\src\share\replaygain_analysis\replaygain_analysis.c
FLAC_REPLAYGAIN_SYNTHESIS_SRC = ..\src\share\replaygain_synthesis\replaygain_synthesis.c
FLAC_UTF8_SRC = ..\src\share\utf8\utf8.c
FLAC_WIN32_UTF8_IO_SRC = ..\src\share\win_utf8_io\win_utf8_io.c

# Shared objects (grabbag objects are done below using create-lists.bat)
FLAC_WIN32_SHARED_OBJ = $(CFG)\$(PLAT)\share\windows_unicode_filenames.obj
FLAC_GETOPT_OBJS = $(CFG)\$(PLAT)\share\getopt.obj $(CFG)\$(PLAT)\share\getopt1.obj
FLAC_REPLAYGAIN_ANALYSIS_OBJ = $(CFG)\$(PLAT)\share\replaygain_analysis.obj
FLAC_REPLAYGAIN_SYNTHESIS_OBJ = $(CFG)\$(PLAT)\share\replaygain_synthesis.obj
FLAC_UTF8_OBJ = $(CFG)\$(PLAT)\share\utf8.obj
FLAC_WIN32_UTF8_IO_OBJ = $(CFG)\$(PLAT)\share\win_utf8_io.obj

# For libflac
FLAC_SRCS =	\
	..\src\libFLAC\bitmath.c	\
	..\src\libFLAC\bitreader.c	\
	..\src\libFLAC\bitwriter.c	\
	..\src\libFLAC\cpu.c	\
	..\src\libFLAC\crc.c	\
	..\src\libFLAC\fixed.c	\
	..\src\libFLAC\fixed_intrin_sse2.c	\
	..\src\libFLAC\fixed_intrin_ssse3.c	\
	..\src\libFLAC\float.c	\
	..\src\libFLAC\format.c	\
	..\src\libFLAC\lpc.c	\
	..\src\libFLAC\lpc_intrin_sse.c	\
	..\src\libFLAC\lpc_intrin_sse2.c	\
	..\src\libFLAC\lpc_intrin_sse41.c	\
	..\src\libFLAC\md5.c	\
	..\src\libFLAC\memory.c	\
	..\src\libFLAC\metadata_iterators.c	\
	..\src\libFLAC\metadata_object.c	\
	..\src\libFLAC\ogg_decoder_aspect.c	\
	..\src\libFLAC\ogg_encoder_aspect.c	\
	..\src\libFLAC\ogg_helper.c	\
	..\src\libFLAC\ogg_mapping.c	\
	..\src\libFLAC\stream_decoder.c	\
	..\src\libFLAC\stream_encoder.c	\
	..\src\libFLAC\stream_encoder_framing.c	\
	..\src\libFLAC\stream_encoder_intrin_sse2.c	\
	..\src\libFLAC\stream_encoder_intrin_ssse3.c	\
	..\src\libFLAC\window.c

FLACPP_SRCS =	\
	..\src\libFLAC++\metadata.cpp	\
	..\src\libFLAC++\stream_decoder.cpp	\
	..\src\libFLAC++\stream_encoder.cpp

!if "$(PLAT)" == "Win32"
FLAC_ASM_SRCS =	\
	..\src\libFLAC\ia32\cpu_asm.nasm	\
	..\src\libFLAC\ia32\fixed_asm.nasm	\
	..\src\libFLAC\ia32\lpc_asm.nasm
!else
FLAC_ASM_SRCS =
!endif

.SUFFIXES : .c .h .cpp .nasm

!if $(VSVER) > 9
FLAC_AVX_SRCS =	\
	..\src\libFLAC\lpc_intrin_avx2.c	\
	..\src\libFLAC\stream_encoder_intrin_avx2.c
!else
FLAC_AVX_SRCS =
!endif

FLAC_EXE_SRCS =	\
	..\src\flac\analyze.c	\
	..\src\flac\decode.c	\
	..\src\flac\encode.c	\
	..\src\flac\foreign_metadata.c	\
	..\src\flac\main.c	\
	..\src\flac\local_string_utils.c	\
	..\src\flac\utils.c	\
	..\src\flac\vorbiscomment.c

IFFSCAN_SRCS =	\
	..\src\flac\iffscan.c	\
	..\src\flac\foreign_metadata.c

METAFLAC_SRCS =	\
	..\src\metaflac\main.c	\
	..\src\metaflac\operations.c	\
	..\src\metaflac\operations_shorthand_cuesheet.c	\
	..\src\metaflac\operations_shorthand_picture.c	\
	..\src\metaflac\operations_shorthand_seektable.c	\
	..\src\metaflac\operations_shorthand_streaminfo.c	\
	..\src\metaflac\operations_shorthand_vorbiscomment.c	\
	..\src\metaflac\options.c	\
	..\src\metaflac\usage.c	\
	..\src\metaflac\utils.c

FLACDIFF_OBJS = $(CFG)\$(PLAT)\flacdiff\main.obj
FLACTIMER_OBJS = $(CFG)\$(PLAT)\flactimer\main.obj
EX_C_DEC_FILE_OBJ = $(CFG)\$(PLAT)\ex-c-decode\main.obj
EX_C_ENC_FILE_OBJ = $(CFG)\$(PLAT)\ex-c-encode\main.obj
EX_CPP_DEC_FILE_OBJ = $(CFG)\$(PLAT)\ex-cpp-decode\main.obj
EX_CPP_ENC_FILE_OBJ = $(CFG)\$(PLAT)\ex-cpp-encode\main.obj

TEST_SHARED_OBJS =	\
	$(CFG)\$(PLAT)\share-tests\file_utils_flac.obj	\
	$(CFG)\$(PLAT)\share-tests\metadata_utils.obj

TEST_FLAC_SRCS =	\
	..\src\test_libFLAC\bitwriter.c	\
	..\src\test_libFLAC\decoders.c	\
	..\src\test_libFLAC\encoders.c	\
	..\src\test_libFLAC\endswap.c	\
	..\src\test_libFLAC\format.c	\
	..\src\test_libFLAC\main.c	\
	..\src\test_libFLAC\metadata.c	\
	..\src\test_libFLAC\metadata_manip.c	\
	..\src\test_libFLAC\metadata_object.c	\
	..\src\test_libFLAC\md5.c

TEST_FLACPP_SRCS =	\
	..\src\test_libFLAC++\decoders.cpp	\
	..\src\test_libFLAC++\encoders.cpp	\
	..\src\test_libFLAC++\main.cpp	\
	..\src\test_libFLAC++\metadata.cpp	\
	..\src\test_libFLAC++\metadata_manip.cpp	\
	..\src\test_libFLAC++\metadata_object.cpp

!if [call create-lists.bat header flac_objs.mak flac_dll_OBJS]
!endif

!if [for %c in ($(FLAC_SRCS) $(FLAC_AVX_SRCS)) do @if "%~xc" == ".c" @call create-lists.bat file flac_objs.mak ^$(CFG)\^$(PLAT)\libflac\%~nc.obj]
!endif

!if "$(FLAC_ASM_SRCS)" != ""
!if [for %c in ($(FLAC_ASM_SRCS)) do @if "%~xc" == ".nasm" @call create-lists.bat file flac_objs.mak ^$(CFG)\^$(PLAT)\libflac\%~nc.obj]
!endif
!endif

!if [call create-lists.bat footer flac_objs.mak]
!endif

!if [call create-lists.bat header flac_objs.mak flac_static_OBJS]
!endif

!if [for %c in ($(FLAC_SRCS) $(FLAC_WIN32_SHARED_SRC) $(FLAC_AVX_SRCS)) do @if "%~xc" == ".c" @call create-lists.bat file flac_objs.mak ^$(CFG)\^$(PLAT)\libflac-static\%~nc.obj]
!endif

!if "$(FLAC_ASM_SRCS)" != ""
!if [for %c in ($(FLAC_ASM_SRCS)) do @if "%~xc" == ".nasm" @call create-lists.bat file flac_objs.mak ^$(CFG)\^$(PLAT)\libflac-static\%~nc.obj]
!endif
!endif

!if [call create-lists.bat footer flac_objs.mak]
!endif

!if [call create-lists.bat header flac_objs.mak flacpp_dll_OBJS]
!endif

!if [for %c in ($(FLACPP_SRCS)) do @if "%~xc" == ".cpp" @call create-lists.bat file flac_objs.mak ^$(CFG)\^$(PLAT)\libflac++\%~nc.obj]
!endif

!if [call create-lists.bat footer flac_objs.mak]
!endif

!if [call create-lists.bat header flac_objs.mak flac_grabbag_OBJS]
!endif

!if [for %c in ($(FLAC_GRABBAG_SRCS)) do @if "%~xc" == ".c" @call create-lists.bat file flac_objs.mak ^$(CFG)\^$(PLAT)\share\%~nc.obj]
!endif

!if [call create-lists.bat footer flac_objs.mak]
!endif

!if [call create-lists.bat header flac_objs.mak flac_OBJS]
!endif

!if [for %c in ($(FLAC_EXE_SRCS)) do @if "%~xc" == ".c" @call create-lists.bat file flac_objs.mak ^$(CFG)\^$(PLAT)\flac\%~nc.obj]
!endif

!if [call create-lists.bat footer flac_objs.mak]
!endif

!if [call create-lists.bat header flac_objs.mak iffscan_OBJS]
!endif

!if [for %c in ($(IFFSCAN_SRCS)) do @if "%~xc" == ".c" @call create-lists.bat file flac_objs.mak ^$(CFG)\^$(PLAT)\flac\%~nc.obj]
!endif

!if [call create-lists.bat footer flac_objs.mak]
!endif

!if [call create-lists.bat header flac_objs.mak metaflac_OBJS]
!endif

!if [for %c in ($(METAFLAC_SRCS)) do @if "%~xc" == ".c" @call create-lists.bat file flac_objs.mak ^$(CFG)\^$(PLAT)\metaflac\%~nc.obj]
!endif

!if [call create-lists.bat footer flac_objs.mak]
!endif

!if [call create-lists.bat header flac_objs.mak test_flac_OBJS]
!endif

!if [for %c in ($(TEST_FLAC_SRCS)) do @if "%~xc" == ".c" @call create-lists.bat file flac_objs.mak ^$(CFG)\^$(PLAT)\test-flac\%~nc.obj]
!endif

!if [call create-lists.bat footer flac_objs.mak]
!endif

!if [call create-lists.bat header flac_objs.mak test_flacpp_OBJS]
!endif

!if [for %c in ($(TEST_FLACPP_SRCS)) do @if "%~xc" == ".cpp" @call create-lists.bat file flac_objs.mak ^$(CFG)\^$(PLAT)\test-flac++\%~nc.obj]
!endif

!if [call create-lists.bat footer flac_objs.mak]
!endif

!include flac_objs.mak

!if [del /f /q flac_objs.mak]
!endif
