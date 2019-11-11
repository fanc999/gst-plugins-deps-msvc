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

# For libkate

!if [call create-lists.bat header libkate_objs.mak libkate_OBJS]
!endif

!if [for %c in (..\..\..\..\src\*.c) do @if not "%~nc" == "kate_ogg" @call create-lists.bat file libkate_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libkate\%~nc.obj]
!endif

!if [call create-lists.bat footer libkate_objs.mak]
!endif

# For liboggkate
!if [call create-lists.bat header libkate_objs.mak liboggkate_OBJS]
!endif

!if [for %c in (..\..\..\..\src\kate_ogg.c) do @call create-lists.bat file libkate_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libkate\%~nc.obj]
!endif

!if [call create-lists.bat footer libkate_objs.mak]
!endif

!ifdef TOOLS

!if [call create-lists.bat header libkate_objs.mak kate_tools_common_OBJS]
!endif

!if [for %c in (kutil.c kstream.c kread.c kstrings.c) do @call create-lists.bat file libkate_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libkate-tools\%~nc.obj]
!endif

!if [call create-lists.bat footer libkate_objs.mak]
!endif

!if [call create-lists.bat header libkate_objs.mak kateenc_OBJS]
!endif

!if [for %c in (kateenc.c kate_lexer.l kate_parser.y) do @call create-lists.bat file libkate_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libkate-tools\%~nc.obj]
!endif

!ifdef PNG

!if [for %c in (..\..\..\..\tools\kpng.c) do @call create-lists.bat file libkate_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libkate-tools\%~nc.obj]
!endif

!endif

!if [call create-lists.bat footer libkate_objs.mak]
!endif

!if [call create-lists.bat header libkate_objs.mak katedec_OBJS]
!endif

!if [for %c in (katedec.c kkate.c ksrt.c klrc.c kfuzz.c) do @call create-lists.bat file libkate_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libkate-tools\%~nc.obj]
!endif

!if [call create-lists.bat footer libkate_objs.mak]
!endif

!if [call create-lists.bat header libkate_objs.mak katalyzer_OBJS]
!endif

!if [for %c in (katalyzer.c kstats.c) do @call create-lists.bat file libkate_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libkate-tools\%~nc.obj]
!endif

!if [call create-lists.bat footer libkate_objs.mak]
!endif

!endif

!include libkate_objs.mak

!if [del /f /q libkate_objs.mak]
!endif
