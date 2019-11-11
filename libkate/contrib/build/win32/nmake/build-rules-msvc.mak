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

{..\..\..\..\src\}.c{vs$(VSVER)\$(CFG)\$(PLAT)\libkate\}.obj::
	@if not exist vs$(VSVER)\$(CFG)\$(PLAT)\libkate\ $(MAKE) /f Makefile.vc CFG=$(CFG) vs$(VSVER)\$(CFG)\$(PLAT)\libkate
	$(CC) $(CFLAGS) $(LIBKATE_CFLAGS) $(BASE_INCLUDES) /Fovs$(VSVER)\$(CFG)\$(PLAT)\libkate\ /Fdvs$(VSVER)\$(CFG)\$(PLAT)\libkate\ /c @<<
$<
<<

{..\..\..\..\tools\}.c{vs$(VSVER)\$(CFG)\$(PLAT)\libkate-tools\}.obj::
	@if not exist vs$(VSVER)\$(CFG)\$(PLAT)\libkate-tools\ $(MAKE) /f Makefile.vc CFG=$(CFG) vs$(VSVER)\$(CFG)\$(PLAT)\libkate-tools
	$(CC) $(CFLAGS) $(TOOLS_CFLAGS) $(TOOLS_INCLUDES) /Fovs$(VSVER)\$(CFG)\$(PLAT)\libkate-tools\ /Fdvs$(VSVER)\$(CFG)\$(PLAT)\libkate-tools\ /c @<<
$<
<<

# Rules for building .lib files
!ifndef STATIC
$(KATE_LIB): $(KATE_LIB:.lib=.dll)
$(KATE_OGG_LIB): $(KATE_OGG_LIB:.lib=.dll)
!else
$(KATE_LIB): $(libkate_OBJS)
$(KATE_OGG_LIB): $(liboggkate_OBJS)

$(KATE_LIB) $(KATE_OGG_LIB):
	lib $(ARFLAGS) /out:$@ @<<
$**
<<
!endif

# Rules for linking DLLs
# Format is as follows (the mt command is needed for MSVC 2005/2008 builds):
# $(dll_name_with_path): $(dependent_libs_files_objects_and_items)
#	link /DLL [$(linker_flags)] [$(dependent_libs)] [/def:$(def_file_if_used)] [/implib:$(lib_name_if_needed)] -out:$@ @<<
# $(dependent_objects)
# <<
# 	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2
$(KATE_LIB:.lib=.dll): $(libkate_OBJS)
$(KATE_OGG_LIB:.lib=.dll): $(KATE_LIB) $(liboggkate_OBJS)

$(KATE_LIB:.lib=.dll) $(KATE_OGG_LIB:.lib=.dll):
	link /DLL $(LDFLAGS) $(BASE_DEP_LIBS)		\
	-out:$@ @<<
$**
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2

# Rules for linking Executables
# Format is as follows (the mt command is needed for MSVC 2005/2008 builds):
# $(dll_name_with_path): $(dependent_libs_files_objects_and_items)
#	link [$(linker_flags)] [$(dependent_libs)] -out:$@ @<<
# $(dependent_objects)
# <<
# 	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1
vs$(VSVER)\$(CFG)\$(PLAT)\kateenc.exe: $(KATE_OGG_LIB) $(KATE_LIB) $(kateenc_OBJS)
vs$(VSVER)\$(CFG)\$(PLAT)\katedec.exe: $(KATE_OGG_LIB) $(KATE_LIB) $(katedec_OBJS) $(kate_tools_common_OBJS)
vs$(VSVER)\$(CFG)\$(PLAT)\katalyzer.exe: $(KATE_OGG_LIB) $(KATE_LIB) $(katalyzer_OBJS) $(kate_tools_common_OBJS)

vs$(VSVER)\$(CFG)\$(PLAT)\kateenc.exe	\
vs$(VSVER)\$(CFG)\$(PLAT)\katedec.exe	\
vs$(VSVER)\$(CFG)\$(PLAT)\katalyzer.exe:
	link $(LDFLAGS) $(KATE_TOOLS_DEP_LIBS) /out:$@ @<<
$**
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;1

clean:
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.exe.manifest
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.exe
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.dll.manifest
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.dll
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.pdb
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.ilk
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.exp
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.lib
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\libkate-tools\vc$(PDBVER)0.pdb
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\libkate-tools\*.obj
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\libkate\vc$(PDBVER)0.pdb
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\libkate\*.obj
