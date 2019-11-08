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

# For libmpg123

!if [call create-lists.bat header libmpg123_asm.mak win32_asm_int_srcs]
!endif

#x86
!if "$(PLAT)" == "Win32"
!if [for %s in (..\..\..\src\libmpg123\*3dnow*.S) do @call create-lists.bat file libmpg123_asm.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libmpg123\%~ns.asm]
!endif

!if [for %s in (..\..\..\src\libmpg123\*sse*.S) do @call create-lists.bat file libmpg123_asm.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libmpg123\%~ns.asm]
!endif

!if [for %s in (..\..\..\src\libmpg123\*mmx*.S) do @call create-lists.bat file libmpg123_asm.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libmpg123\%~ns.asm]
!endif

!if [for %s in (..\..\..\src\libmpg123\synth_i586.S ..\..\..\src\libmpg123\getcpuflags.S) do @call create-lists.bat file libmpg123_asm.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libmpg123\%~ns.asm]
!endif

#x64
!else

!if [for %s in (..\..\..\src\libmpg123\*x86_64*.S) do @call create-lists.bat file libmpg123_asm.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libmpg123\%~ns.asm]
!endif

!endif

!if [call create-lists.bat footer libmpg123_asm.mak]
!endif

!include libmpg123_asm.mak

!if [del /f /q libmpg123_asm.mak]
!endif

!if [call create-lists.bat header libmpg123_objs.mak libmpg123_compat_OBJS]
!endif

!if [for %c in (..\..\..\src\compat\*.c) do @call create-lists.bat file libmpg123_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libmpg123\%~nc.obj]
!endif

!if [call create-lists.bat footer libmpg123_objs.mak]
!endif

!if [call create-lists.bat header libmpg123_objs.mak libmpg123_OBJS]
!endif

!if [for %c in (..\*.c) do @call create-lists.bat file libmpg123_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libmpg123\%~nc.obj]
!endif

!if [for %c in (..\..\..\src\libmpg123\*.c) do @if not "%~nc" == "dct64_altivec" if not "%~nc" == "dct64_i386" if not "%~nc" == "dct64_i486" if not "%~nc" == "getcpuflags_arm" if not "%~nc" == "lfs_alias" if not "%~nc" == "lfs_wrap" if not "%~nc" == "synth_altivec" if not "%~nc" == "synth_i486" if not "%~nc" == "testcpu" @call create-lists.bat file libmpg123_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libmpg123\%~nc.obj]
!endif

!ifndef NO_ASM

!if [for %c in ($(win32_asm_int_srcs) ..\..\..\src\libmpg123\dct64_i386.c) do @call create-lists.bat file libmpg123_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libmpg123\%~nc.obj]
!endif

!endif

!if [call create-lists.bat footer libmpg123_objs.mak]
!endif

# No assembly code
!ifdef NO_ASM
LIBMPG123_INT_SRCS =
!else
LIBMPG123_INT_SRCS = $(win32_asm_int_srcs)
!endif

!if [call create-lists.bat header libmpg123_objs.mak libout123_OBJS]
!endif

!if [for %c in (..\..\..\src\libout123\*.c) do @if not "%~nc" == "buffer" if not "%~nc" == "module" if not "%~nc" == "xfermem" @call create-lists.bat file libmpg123_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libout123\%~nc.obj]
!endif

!ifdef WASAPI
# Use WASAPI output
!if [for %c in (..\..\..\src\libout123\modules\win32_wasapi.c) do @call create-lists.bat file libmpg123_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libout123\%~nc.obj]
!endif

!else
!ifdef SDL
# Use SDL output
!if [for %c in (..\..\..\src\libout123\modules\sdl.c) do @call create-lists.bat file libmpg123_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libout123\%~nc.obj]
!endif

!else
# Use legacy win32 output
!if [for %c in (..\..\..\src\libout123\modules\win32.c) do @call create-lists.bat file libmpg123_objs.mak vs^$(VSVER)\^$(CFG)\^$(PLAT)\libout123\%~nc.obj]
!endif
!endif
!endif

!if [call create-lists.bat footer libmpg123_objs.mak]
!endif

!include libmpg123_objs.mak

!if [del /f /q libmpg123_objs.mak]
!endif
