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

{..\libtwolame\}.c{vs$(VSVER)\$(CFG)\$(PLAT)\libtwolame\}.obj::
	@if not exist vs$(VSVER)\$(CFG)\$(PLAT)\libtwolame\ $(MAKE) /f Makefile.vc CFG=$(CFG) vs$(VSVER)\$(CFG)\$(PLAT)\libtwolame
	$(CC) $(CFLAGS) $(LIBTWOLAME_CFLAGS) $(BASE_INCLUDES) /Fovs$(VSVER)\$(CFG)\$(PLAT)\libtwolame\ /Fdvs$(VSVER)\$(CFG)\$(PLAT)\libtwolame\ /c @<<
$<
<<

# Rules for building .lib files
!ifndef STATIC
$(TWOLAME_LIB): $(TWOLAME_LIB:.lib=.dll)
!else
$(TWOLAME_LIB): $(libtwolame_OBJS)
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
$(TWOLAME_LIB:.lib=.dll): $(libtwolame_OBJS)
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

clean:
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.dll.manifest
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.dll
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.pdb
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.ilk
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.exp
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.lib
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\libtwolame\vc$(PDBVER)0.pdb
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\libtwolame\*.obj
