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

# For libspeex

!if [call create-lists.bat header libspeex_objs.mak libspeex_OBJS]
!endif

!if [for %c in (..\..\libspeex\*.c) do @if not "%~nc" == "vorbis_psy" if not "%~nc" == "kiss_fft" if not "%~nc" == "kiss_fftr" if not "%~nc" == "smallft" if not "%~nc" == "testenc" if not "%~nc" == "testenc_wb" if not "%~nc" == "testenc_uwb" @call create-lists.bat file libspeex_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\speex\%~nc.obj]
!endif

!ifdef VORBIS

# Build vorbis_psy.c
!if [for %c in (..\..\libspeex\vorbis_psy.c) do @call create-lists.bat file libspeex_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\speex\%~nc.obj]
!endif

!endif

!ifndef NO_KISS_FFT

# Build kiss_fft sources
!if [for %c in (..\..\libspeex\kiss_fft.c ..\..\..\libspeex\kiss_fftr.c) do @call create-lists.bat file libspeex_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\speex\%~nc.obj]
!endif

!endif

!ifndef NO_SMALL_FFT

# Build small_fft sources
!if [for %c in (..\..\libspeex\smallft.c) do @call create-lists.bat file libspeex_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\speex\%~nc.obj]
!endif

!endif

!if [call create-lists.bat footer libspeex_objs.mak]
!endif

!if [call create-lists.bat header libspeex_objs.mak speex_tools_common_OBJS]
!endif

!if [for %c in (getopt getopt1 wav_io) do @call create-lists.bat file libspeex_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\speex-tools\%c.obj]
!endif

!if [call create-lists.bat footer libspeex_objs.mak]
!endif

!if [call create-lists.bat header libspeex_objs.mak speexenc_OBJS]
!endif

!if [for %c in (speexenc skeleton) do @call create-lists.bat file libspeex_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\speex-tools\%c.obj]
!endif

!if [call create-lists.bat footer libspeex_objs.mak]
!endif

!if [call create-lists.bat header libspeex_objs.mak speexdec_OBJS]
!endif

!if [for %c in (speexdec wave_out) do @call create-lists.bat file libspeex_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\speex-tools\%c.obj]
!endif

!if [call create-lists.bat footer libspeex_objs.mak]
!endif

!include libspeex_objs.mak

!if [del /f /q libspeex_objs.mak]
!endif
