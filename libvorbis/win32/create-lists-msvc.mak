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

# For libvorbis
LIBVORBISENC_SRCS = ..\lib\vorbisenc.c
LIBVORBISFILE_SRCS = ..\lib\vorbisfile.c

LIBVORBIS_SRCS =	\
	..\lib\analysis.c	\
	..\lib\bitrate.c	\
	..\lib\block.c	\
	..\lib\codebook.c	\
	..\lib\envelope.c	\
	..\lib\floor0.c	\
	..\lib\floor1.c	\
	..\lib\info.c	\
	..\lib\lookup.c	\
	..\lib\lpc.c	\
	..\lib\lsp.c	\
	..\lib\mapping0.c	\
	..\lib\mdct.c	\
	..\lib\psy.c	\
	..\lib\registry.c	\
	..\lib\res0.c	\
	..\lib\sharedbook.c	\
	..\lib\smallft.c	\
	..\lib\synthesis.c	\
	..\lib\window.c	\
	$(LIBVORBISENC_SRCS)

VORBIS_TEST_SRCS =	\
	..\test\test.c	\
	..\test\util.c	\
	..\test\write_read.c

EX_CHAINING_OBJ = $(CFG)\$(PLAT)\vorbis-ex\chaining_example.obj
EX_DECODER_OBJ = $(CFG)\$(PLAT)\vorbis-ex\decoder_example.obj
EX_ENCODER_OBJ = $(CFG)\$(PLAT)\vorbis-ex\encoder_example.obj
EX_SEEKING_OBJ = $(CFG)\$(PLAT)\vorbis-ex\seeking_example.obj
EX_VORBISFILE_OBJ = $(CFG)\$(PLAT)\vorbis-ex\vorbisfile_example.obj

!if [call create-lists.bat header vorbis_objs.mak vorbis_dll_OBJS]
!endif

!if [for %c in ($(LIBVORBIS_SRCS)) do @if "%~xc" == ".c" @call create-lists.bat file vorbis_objs.mak ^$(CFG)\^$(PLAT)\libvorbis\%~nc.obj]
!endif

!if [call create-lists.bat footer vorbis_objs.mak]
!endif

!if [call create-lists.bat header vorbis_objs.mak vorbisenc_dll_OBJS]
!endif

!if [for %c in ($(LIBVORBISENC_SRCS)) do @if "%~xc" == ".c" @call create-lists.bat file vorbis_objs.mak ^$(CFG)\^$(PLAT)\libvorbis\%~nc.obj]
!endif

!if [call create-lists.bat footer vorbis_objs.mak]
!endif

!if [call create-lists.bat header vorbis_objs.mak vorbisfile_dll_OBJS]
!endif

!if [for %c in ($(LIBVORBISFILE_SRCS)) do @if "%~xc" == ".c" @call create-lists.bat file vorbis_objs.mak ^$(CFG)\^$(PLAT)\libvorbis\%~nc.obj]
!endif

!if [call create-lists.bat footer vorbis_objs.mak]
!endif

!if [call create-lists.bat header vorbis_objs.mak vorbis_test_OBJS]
!endif

!if [for %c in ($(VORBIS_TEST_SRCS)) do @if "%~xc" == ".c" @call create-lists.bat file vorbis_objs.mak ^$(CFG)\^$(PLAT)\test\%~nc.obj]
!endif

!if [call create-lists.bat footer vorbis_objs.mak]
!endif

!include vorbis_objs.mak

!if [del /f /q vorbis_objs.mak]
!endif
