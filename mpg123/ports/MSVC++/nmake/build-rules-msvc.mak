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

.SUFFIXES: .exe .obj .asm .S .c

{..\..\..\src\libmpg123\}.S{vs$(VSVER)\$(CFG)\$(PLAT)\libmpg123\}.asm:
	@if not exist $(@D)\ $(MAKE) /f Makefile.vc CFG=$(CFG) $(@D)
	$(CPP) /EP /TC $(BASE_INCLUDES) $(OPT_FLAGS) $< > $@

{vs$(VSVER)\$(CFG)\$(PLAT)\libmpg123\}.asm{vs$(VSVER)\$(CFG)\$(PLAT)\libmpg123\}.obj:
	$(YASM) $(YASM_FLAGS) -o $@ $<

{..\..\..\src\libmpg123\}.c{vs$(VSVER)\$(CFG)\$(PLAT)\libmpg123\}.obj::
	@if not exist vs$(VSVER)\$(CFG)\$(PLAT)\libmpg123\ $(MAKE) /f Makefile.vc CFG=$(CFG) vs$(VSVER)\$(CFG)\$(PLAT)\libmpg123
	$(CC) $(CFLAGS) $(LIBMPG123_CFLAGS) $(BASE_INCLUDES) /Fovs$(VSVER)\$(CFG)\$(PLAT)\libmpg123\ /Fdvs$(VSVER)\$(CFG)\$(PLAT)\libmpg123\ /c @<<
$<
<<

{..\..\..\src\compat\}.c{vs$(VSVER)\$(CFG)\$(PLAT)\libmpg123\}.obj::
	@if not exist vs$(VSVER)\$(CFG)\$(PLAT)\libmpg123\ $(MAKE) /f Makefile.vc CFG=$(CFG) vs$(VSVER)\$(CFG)\$(PLAT)\libmpg123
	$(CC) $(CFLAGS) $(LIBMPG123_CFLAGS) $(BASE_INCLUDES) /Fovs$(VSVER)\$(CFG)\$(PLAT)\libmpg123\ /Fdvs$(VSVER)\$(CFG)\$(PLAT)\libmpg123\ /c @<<
$<
<<

{..\}.c{vs$(VSVER)\$(CFG)\$(PLAT)\libmpg123\}.obj::
	@if not exist vs$(VSVER)\$(CFG)\$(PLAT)\libmpg123\ $(MAKE) /f Makefile.vc CFG=$(CFG) vs$(VSVER)\$(CFG)\$(PLAT)\libmpg123
	$(CC) $(CFLAGS) $(LIBMPG123_CFLAGS) $(BASE_INCLUDES) /Fovs$(VSVER)\$(CFG)\$(PLAT)\libmpg123\ /Fdvs$(VSVER)\$(CFG)\$(PLAT)\libmpg123\ /c @<<
$<
<<

{..\..\..\src\libout123\}.c{vs$(VSVER)\$(CFG)\$(PLAT)\libout123\}.obj::
	@if not exist vs$(VSVER)\$(CFG)\$(PLAT)\libout123\ $(MAKE) /f Makefile.vc CFG=$(CFG) vs$(VSVER)\$(CFG)\$(PLAT)\libout123
	$(CC) $(CFLAGS) $(LIBOUT123_CFLAGS) $(LIBOUT123_INCLUDES) /Fovs$(VSVER)\$(CFG)\$(PLAT)\libout123\ /Fdvs$(VSVER)\$(CFG)\$(PLAT)\libout123\ /c @<<
$<
<<

{..\..\..\src\libout123\modules\}.c{vs$(VSVER)\$(CFG)\$(PLAT)\libout123\}.obj::
	@if not exist vs$(VSVER)\$(CFG)\$(PLAT)\libout123\ $(MAKE) /f Makefile.vc CFG=$(CFG) vs$(VSVER)\$(CFG)\$(PLAT)\libout123
	$(CC) $(CFLAGS) $(LIBOUT123_CFLAGS) $(LIBOUT123_INCLUDES) /Fovs$(VSVER)\$(CFG)\$(PLAT)\libout123\ /Fdvs$(VSVER)\$(CFG)\$(PLAT)\libout123\ /c @<<
$<
<<

# Rules for building .lib files
!ifndef STATIC
$(MPG123_LIB): $(MPG123_LIB:.lib=.dll)
$(OUT123_LIB): $(OUT123_LIB:.lib=.dll)
!else
$(MPG123_LIB): $(LIBMPG123_INT_SRCS) $(libmpg123_OBJS) $(libmpg123_compat_OBJS)
	lib $(ARFLAGS) /out:$@ @<<
$(libmpg123_OBJS) $(libmpg123_compat_OBJS)
<<

$(OUT123_LIB): $(libout123_OBJS) $(libmpg123_compat_OBJS)
	lib $(ARFLAGS) /out:$@ @<<
$(libout123_OBJS) $(libmpg123_compat_OBJS)
<<
!endif

# Rules for linking DLLs
# Format is as follows (the mt command is needed for MSVC 2005/2008 builds):
# $(dll_name_with_path): $(dependent_libs_files_objects_and_items)
#	link /DLL [$(linker_flags)] [$(dependent_libs)] [/def:$(def_file_if_used)] [/implib:$(lib_name_if_needed)] -out:$@ @<<
# $(dependent_objects)
# <<
# 	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2
$(MPG123_LIB:.lib=.dll): $(LIBMPG123_INT_SRCS) $(libmpg123_OBJS) $(libmpg123_compat_OBJS)
	link /DLL $(DLL_LD_FLAGS) $(BASE_DEP_LIBS)		\
	-out:$@ @<<
$(libmpg123_OBJS) $(libmpg123_compat_OBJS)
<<
	@-if exist $@.manifest mt /manifest $@.manifest /outputresource:$@;2
	
$(OUT123_LIB:.lib=.dll): $(libout123_OBJS) $(libmpg123_compat_OBJS)
	link /DLL $(DLL_LD_FLAGS) $(LIBOUT123_DEP_LIBS)		\
	-out:$@ @<<
$(libout123_OBJS) $(libmpg123_compat_OBJS)
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
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.dll
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.pdb
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.ilk
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.exp
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\*.lib
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\libout123\vc$(PDBVER)0.pdb
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\libout123\*.obj
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\libmpg123\vc$(PDBVER)0.pdb
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\libmpg123\*.obj
	@-del /f /q vs$(VSVER)\$(CFG)\$(PLAT)\libmpg123\*.asm
