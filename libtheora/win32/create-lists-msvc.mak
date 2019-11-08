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

# For libtheora
LIBTHEORA_ENC_INTRINSIC_SRCS =	\
	..\lib\x86_vc\mmxencfrag.c	\
	..\lib\x86_vc\mmxfdct.c	\
	..\lib\x86_vc\x86enc.c

LIBTHEORA_SHARED_INTRINSIC_SRCS =	\
	..\lib\x86_vc\mmxfrag.c	\
	..\lib\x86_vc\mmxidct.c	\
	..\lib\x86_vc\mmxstate.c	\
	..\lib\x86_vc\x86state.c

LIBTHEORA_COMMON_SRCS =	\
	..\lib\apiwrapper.c \
	..\lib\fragment.c \
	..\lib\idct.c \
	..\lib\info.c \
	..\lib\internal.c \
	..\lib\state.c \
	..\lib\quant.c

LIBTHEORA_ENC_SRCS =	\
	..\lib\analyze.c \
	..\lib\fdct.c \
	..\lib\encfrag.c \
	..\lib\encapiwrapper.c \
	..\lib\encinfo.c \
	..\lib\encode.c \
	..\lib\enquant.c \
	..\lib\huffenc.c \
	..\lib\mathops.c \
	..\lib\mcenc.c \
	..\lib\rate.c \
	..\lib\tokenize.c \
	$(LIBTHEORA_ENC_INTRINSIC_SRCS)

LIBTHEORA_DEC_SRCS = \
	..\lib\bitpack.c \
	..\lib\decapiwrapper.c \
	..\lib\decinfo.c \
	..\lib\decode.c \
	..\lib\dequant.c \
	..\lib\huffdec.c

LIBTHEORA_SRCS =	\
	$(LIBTHEORA_ENC_SRCS)	\
	$(LIBTHEORA_DEC_SRCS)	\
	$(LIBTHEORA_COMMON_SRCS)	\
	$(LIBTHEORA_SHARED_INTRINSIC_SRCS)

!if [call create-lists.bat header theora_objs.mak theora_dll_OBJS]
!endif

!if [for %c in ($(LIBTHEORA_SRCS)) do @if "%~xc" == ".c" @call create-lists.bat file theora_objs.mak ^$(CFG)\^$(PLAT)\libtheora\%~nc.obj]
!endif

!if [call create-lists.bat footer theora_objs.mak]
!endif

!if [call create-lists.bat header theora_objs.mak theoraenc_dll_OBJS]
!endif

!if [for %c in ($(LIBTHEORA_ENC_SRCS) $(LIBTHEORA_COMMON_SRCS) $(LIBTHEORA_SHARED_INTRINSIC_SRCS)) do @if "%~xc" == ".c" @call create-lists.bat file theora_objs.mak ^$(CFG)\^$(PLAT)\libtheora\%~nc.obj]
!endif

!if [call create-lists.bat footer theora_objs.mak]
!endif

!if [call create-lists.bat header theora_objs.mak theoradec_dll_OBJS]
!endif

!if [for %c in ($(LIBTHEORA_DEC_SRCS) $(LIBTHEORA_COMMON_SRCS) $(LIBTHEORA_SHARED_INTRINSIC_SRCS)) do @if "%~xc" == ".c" @call create-lists.bat file theora_objs.mak ^$(CFG)\^$(PLAT)\libtheora\%~nc.obj]
!endif

!if [call create-lists.bat footer theora_objs.mak]
!endif

!if [call create-lists.bat header theora_objs.mak theora_test_OBJS]
!endif

!if [for %c in ($(theora_TEST_SRCS)) do @if "%~xc" == ".c" @call create-lists.bat file theora_objs.mak ^$(CFG)\^$(PLAT)\test\%~nc.obj]
!endif

!if [call create-lists.bat footer theora_objs.mak]
!endif

!include theora_objs.mak

!if [del /f /q theora_objs.mak]
!endif
