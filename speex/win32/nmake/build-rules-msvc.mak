# NMake Makefile portion for compilation rules
# Items in here should not need to be edited unless
# one is maintaining the NMake build files.  The format
# of NMake Makefiles here are different from the GNU
# Makefiles.  Please see the comments about these formats.

# Inference rules for compiling the .obj files.
# Used for libs and programs with more than a single source file.
# Format is as follows
# (all dirs must have a trailing '\'):
#
# {$(srcdir)}.$(srcext){$(destdir)}.obj::
# 	$(CC)|$(CXX) $(cflags) /Fo$(destdir) /c @<<
# $<
# <<

{..\..\libspeex\}.c{vs$(VSVER)\$(CFG)\$(PLAT)\speex\}.obj::
	@if not exist vs$(VSVER)\$(CFG)\$(PLAT)\speex\ $(MAKE) /f Makefile.vc CFG=$(CFG) vs$(VSVER)\$(CFG)\$(PLAT)\speex
	$(CC) $(CFLAGS) $(SPEEX_CFLAGS) $(BASE_INCLUDES) /Fovs$(VSVER)\$(CFG)\$(PLAT)\speex\ /Fdvs$(VSVER)\$(CFG)\$(PLAT)\speex\ /c @<<
$<
<<

{..\..\src\}.c{vs$(VSVER)\$(CFG)\$(PLAT)\speex-tools\}.obj::
	@if not exist vs$(VSVER)\$(CFG)\$(PLAT)\speex-tools\ $(MAKE) /f Makefile.vc CFG=$(CFG) vs$(VSVER)\$(CFG)\$(PLAT)\speex-tools
	$(CC) $(CFLAGS) $(SPEEX_TOOLS_CFLAGS) $(BASE_INCLUDES) /Fovs$(VSVER)\$(CFG)\$(PLAT)\speex-tools\ /Fdvs$(VSVER)\$(CFG)\$(PLAT)\speex-tools\ /c @<<
$<
<<

# Rules for building .lib files
!ifndef STATIC
$(SPEEX_LIB): $(SPEEX_LIB:.lib=.dll)
!else
$(SPEEX_LIB): $(libspeex_OBJS)
	lib $(ARFLAGS) /out:$@ @<<
$(libspeex_OBJS)
<<
!endif

# Rules for linking DLLs
# Format is as follows (the mt command is needed for MSVC 2005/2008 builds):
# $(dll_name_with_path): $(dependent_libs_files_objects_and_items)
#	link /DLL [$(linker_flags)] [$(dependent_libs)] [/def:$(def_file_if_used)] [/implib:$(lib_name_if_needed)] -out:$@ @<<
# $(dependent_objects)
# <<
# 	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2
$(SPEEX_LIB:.lib=.dll): $(libspeex_OBJS)
	link /DLL $(LDFLAGS) $(BASE_DEP_LIBS)		\
	-out:$@ @<<
$(libspeex_OBJS)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2

# Rules for linking Executables
# Format is as follows (the mt command is needed for MSVC 2005/2008 builds):
# $(dll_name_with_path): $(dependent_libs_files_objects_and_items)
#	link [$(linker_flags)] [$(dependent_libs)] -out:$@ @<<
# $(dependent_objects)
# <<
# 	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1
vs$(VSVER)\$(CFG)\$(PLAT)\speexenc.exe: $(SPEEX_LIB) $(speexenc_OBJS) $(speex_tools_common_OBJS)
vs$(VSVER)\$(CFG)\$(PLAT)\speexdec.exe: $(SPEEX_LIB) $(speexdec_OBJS) $(speex_tools_common_OBJS)

vs$(VSVER)\$(CFG)\$(PLAT)\speexenc.exe vs$(VSVER)\$(CFG)\$(PLAT)\speexdec.exe:
	link $(LDFLAGS) $(SPEEX_TOOLS_DEP_LIBS) /out:$@ @<<
$**
<<

clean:
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.exe
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.dll
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.pdb
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.ilk
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.exp
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.lib
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\speex-tools\vc$(PDBVER)0.pdb
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\speex-tools\*.obj
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\speex\vc$(PDBVER)0.pdb
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\speex\*.obj
